// ignore_for_file: prefer_final_fields

import 'dart:developer';

import 'package:ecos12_chat_app/class/date.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/class/socket/peer_server.dart';
import 'package:ecos12_chat_app/class/socket/peer_system.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';
import 'package:ecos12_chat_app/class/model/message_model.dart';
import 'package:ecos12_chat_app/class/user_name.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:network_info_plus/network_info_plus.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  late WebSocketChat typeWebSocketChat;

  _ChatStoreBase(this.typeWebSocketChat);

  @observable
  ObservableList<ConversationStore> _conversationStore = <ConversationStore>[].asObservable();
  @computed
  List<ConversationStore> get listConversation {
    return _conversationStore.toList();
  }

  @action
  void addConversationStore(ConversationStore conversationStore) {
    _conversationStore.add(conversationStore);
    sort();
  }

  @action
  Future<void> sort() async {
    _conversationStore.sort((ConversationStore a, ConversationStore b) {
      if (a.lastMessage == null && b.lastMessage == null) return 0;

      if (a.lastMessage == null) return -1;
      if (b.lastMessage == null) return 1;

      if (a.lastMessage!.timestamp == null || b.lastMessage!.timestamp == null) {
        if (a.lastMessage!.timestamp == null && b.lastMessage!.timestamp == null) {
          if (a.lastMessage!.timestampSend!.isBefore(b.lastMessage!.timestampSend!)) return 1;
          if (a.lastMessage!.timestampSend!.isAfter(b.lastMessage!.timestampSend!)) return -1;
          return 0;
        }

        if (a.lastMessage!.timestamp == null) {
          if (a.lastMessage!.timestampSend!.isBefore(b.lastMessage!.timestamp!)) return 1;
          if (a.lastMessage!.timestampSend!.isAfter(b.lastMessage!.timestamp!)) return -1;
          return 0;
        }
        if (b.lastMessage!.timestamp == null) {
          if (a.lastMessage!.timestamp!.isBefore(b.lastMessage!.timestampSend!)) return 1;
          if (a.lastMessage!.timestamp!.isAfter(b.lastMessage!.timestampSend!)) return -1;
          return 0;
        }
      }

      if (a.lastMessage!.timestamp!.isBefore(b.lastMessage!.timestamp!)) return 1;
      if (a.lastMessage!.timestamp!.isAfter(b.lastMessage!.timestamp!)) return -1;
      return 0;
    });
  }

  @action
  ConversationStore? getConversation(String idConversation) {
    // ignore: null_closures
    try {
      return listConversation.firstWhere((element) => element.id == idConversation, orElse: null);
    } catch (_) {
      return null;
    }
  }

  @action
  void cleanConversation() {
    _conversationStore.clear();
  }

  @observable
  WebSocketChat? _socketChat;

  @observable
  PeerServer _peer = PeerServer();

  @action
  Future<void> startWebSocket() async {
    if (_socketChat != null) await _socketChat!.close();

    _socketChat = typeWebSocketChat;
    await _socketChat!.connect();

    String? clientIp;

    if (!_socketChat!.isWeb) {
      try {
        clientIp = await NetworkInfo().getWifiIP();
        await _peer.connect(clientIp);
      } catch (e, s) {
        print(s);
      }
    }

    _socketChat!.send({
      'type': 'sync',
      'token': GetIt.instance.get<UserModel>().token,
      'userIp': clientIp,
    });

    _socketChat!.listen((message) async {
      switch (message['type']) {
        case 'message':
          var isFinded = false;
          for (var element in listConversation) {
            if (element.id == message['conversationId']) {
              isFinded = true;
              element.addMessage(
                MessageModel.fromMap(message)..nameFrom = await UserName.byRegistry(message['senderRegistry']),
              );
              break;
            }
          }

          if (!isFinded) {
            /// Primeira mensagem de uma 'conversation' nova
            final List conversations = await Rest.get(path: '/conversations');
            for (int i = 0; i < conversations.length; i++) {
              var element = conversations[i];
              if (element['id'] == message['conversationId']) {
                await _addConversation(element);
                for (var element in listConversation) {
                  if (element.id == message['conversationId']) {
                    element.addMessage(
                      MessageModel.fromMap(message)..nameFrom = await UserName.byRegistry(message['senderRegistry']),
                    );
                    break;
                  }
                }
                break;
              }
            }
          }
          await sort();
          break;
        case 'messages':
          for (var elementFrom in message['messages']) {
            var element = getConversation(elementFrom['conversationId']);
            if (element == null) {
              await Future.delayed(const Duration(milliseconds: 50));
              element = getConversation(elementFrom['conversationId']);
              if (element == null) {
                await Future.delayed(const Duration(milliseconds: 100));
                element = getConversation(elementFrom['conversationId']);
                if (element == null) {
                  await Future.delayed(const Duration(milliseconds: 250));
                  element = getConversation(elementFrom['conversationId']);
                }
              }
            }
            if (element == null) {
              print('Falha ao encontrar conversação');
              continue;
            }

            element.history(MessageModel(
              text: elementFrom['text'],
              nameFrom: await UserName.byRegistry(elementFrom['senderRegistry']),
              conversationId: elementFrom['conversationId'],
              senderRegistry: elementFrom['senderRegistry'],
              isSender: false, // Será redefinido depois
              timestamp: DateTime.fromMillisecondsSinceEpoch(elementFrom['timestamp']),
            ));
          }

          await sort();
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
    if (data.conversationId.contains('secret:')) {
      PeerSystem.send({
        ...data.sendToMap(),
        'timestamp': Date.dateServer().millisecondsSinceEpoch,
      }, data.conversationId.substring(7));
    } else {
      if (_socketChat == null) print('Sem Conexão');
      _socketChat!.send(data.sendToMap());
    }
  }

  @action
  Future<void> closeConnection() async {
    if (_socketChat == null) return;
    await _socketChat!.close();
  }

  @action
  Future<void> _addConversation(Map map) async {
    String title = 'Desconhecido';

    if (map['title'] != '' && map['title'] != null) {
      title = map['title'];

      addConversationStore(ConversationStore(
        map['id'],
        title,
        true,
      ));
    } else {
      addConversationStore(ConversationStore(
        map['id'],
        'Carregando...',
        false,
      ));

      final user = GetIt.I.get<UserModel>();

      List l = map['participantsRegistry'] ?? [];
      l.remove(user.registry);

      if (l.isNotEmpty) {
        title = await UserName.byRegistry(l.first);
      }

      getConversation(map['id'])!.title = title;
    }
  }
}
