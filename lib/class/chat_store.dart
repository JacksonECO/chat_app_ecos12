import 'dart:developer';

import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';
import 'package:ecos12_chat_app/class/model/message_model.dart';
import 'package:ecos12_chat_app/class/user_name.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  late WebSocketChat typeWebSocketChat;

  _ChatStoreBase(this.typeWebSocketChat);

  @observable
  ObservableList<ConversationStore> _conversationStore = <ConversationStore>[].asObservable();
  @computed
  List<ConversationStore> get listConversation => _conversationStore.toList();
  @computed
  set conversationStore(List<ConversationStore> conversationStore) {
    _conversationStore = conversationStore.asObservable();
  }

  @action
  void addConversationStore(ConversationStore conversationStore) {
    _conversationStore.add(conversationStore);
  }

  @action
  ConversationStore? getConversation(String idConversation) {
    // ignore: null_closures
    return listConversation.firstWhere((element) => element.id == idConversation, orElse: null);
  }

  @action
  void cleanConversation() {
    _conversationStore.clear();
  }

  @observable
  WebSocketChat? _socketChat;

  @action
  Future<void> startWebSocket() async {
    if (_socketChat != null) await _socketChat!.close();

    _socketChat = typeWebSocketChat;
    await _socketChat!.connect();

    _socketChat!.send({
      'type': 'sync',
      'token': GetIt.instance.get<UserModel>().token,
    });

    _socketChat!.listen((message) async {
      switch (message['type']) {
        case 'message':
          var isFinded = false;
          for (var element in listConversation) {
            if (element.id == message['conversationId']) {
              isFinded = true;
              element.addMessage(MessageModel.fromMap(message));
              break;
            }
          }

          if (!isFinded) {
            /// Primeira mensagem de uma 'conversation' nova
            //TODO: Ideal uma nova rota da API
            final List conversations = await Rest.get(path: '/conversations');
            for (var element in conversations) {
              if (element['id'] == message['conversationId']) {
                await _addConversation(element);
                for (var element in listConversation) {
                  if (element.id == message['conversationId']) {
                    element.addMessage(MessageModel.fromMap(message));
                    break;
                  }
                }
                break;
              }
            }
          }
          break;
        case 'messages':
          for (var elementFrom in message['messages']) {
            for (var element in listConversation) {
              if (element.id == elementFrom['conversationId']) {
                element.history(MessageModel(
                  text: elementFrom['text'],
                  nameFrom: await UserName.byRegistry(elementFrom['senderRegistry']),
                  conversationId: elementFrom['conversationId'],
                  senderRegistry: elementFrom['senderRegistry'],
                  isSender: false, // Será redefinido depois
                  timestamp: DateTime.fromMillisecondsSinceEpoch(elementFrom['timestamp']),
                ));
                break;
              }
            }
          }

          break;
        case 'conversations':
          for (var element in message['conversations']) {
            _addConversation(element);
          }
          break;
        case 'error':
          log('', name: 'Error', error: message);
          break;
      }
    });
  }

  @action
  void sendMessage(MessageModel data) {
    if (_socketChat == null) print('Sem Conexão');
    _socketChat!.send(data.sendToMap());
  }

  @action
  Future<void> closeConnection() async {
    if (_socketChat == null) return;
    await _socketChat!.close();
  }

  @action
  Future<void> _addConversation(Map map) async {
    String title = 'Desconhecido';
    bool isGroup = false;

    if (map['title'] != '' && map['title'] != null) {
      title = map['title'];
      isGroup = true;
    } else {
      final user = GetIt.I.get<UserModel>();

      List l = map['participantsRegistry'] ?? [];
      l.remove(user.registry);

      if (l.isNotEmpty) {
        title = await UserName.byRegistry(l.first);
      }
    }

    addConversationStore(ConversationStore(
      map['id'],
      title,
      isGroup,
    ));
  }
}
