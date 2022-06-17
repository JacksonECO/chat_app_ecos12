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
          for (var element in listConversation) {
            if (element.id == message['conversationId']) {
              element.addMessage(MessageModel.fromMap(message));
              break;
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
            String title = element['creatorId'];
            addConversationStore(ConversationStore(
              element['id'],
              await _nameByConversation(element),
              element[title] != '' || element[title] != null,
            ));
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
    // _socketChat!.send({
    //   'type': 'message',
    //   // 'id': 100,
    //   'senderRegistry': '2018010136',
    //   'conversationId': '4a9143ac-26a7-424e-a9e9-16d1e7115260',
    //   'text': data.text,
    // });
  }

  @action
  Future<void> closeConnection() async {
    if (_socketChat == null) return;
    await _socketChat!.close();
  }

  @action
  Future<String> _nameByConversation(Map map) async {
    if (map['title'] != null) {
      return map['title'];
    }

    final user = GetIt.I.get<UserModel>();

    List<String> l = map['participantsRegistry'] ?? [];
    l.remove(user.registry);

    if (l.isEmpty) {
      return 'Desconhecido';
    }

    return UserName.byRegistry(l.first);
  }
}
