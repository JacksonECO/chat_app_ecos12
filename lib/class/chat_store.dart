import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';
import 'package:ecos12_chat_app/class/model/message_model.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  _ChatStoreBase(this.typeWebSocketChat) {
    _messageStore.add(ConversationStore('4b98f912-f5f4-47e9-9c47-3ab75537a7ae', 'Grupo 1', true));
    _messageStore.add(ConversationStore('d740efb6-1fd7-44c4-bd6a-43361839c421', 'Grupo 2', true));
  }

  late WebSocketChat typeWebSocketChat;

  @observable
  ObservableList<ConversationStore> _messageStore = <ConversationStore>[].asObservable();
  @computed
  List<ConversationStore> get listMessage => _messageStore.toList();
  @computed
  set messageStore(List<ConversationStore> messageStore) {
    _messageStore = messageStore.asObservable();
  }

  @action
  ConversationStore? getMessage(String idConversation) {
    // ignore: null_closures
    return listMessage.firstWhere((element) => element.id == idConversation, orElse: null);
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
          for (var element in listMessage) {
            if (element.id == message['conversationId']) {
              element.addMessage(MessageModel.fromMap(message));
              break;
            }
          }
          break;
        case 'messages':
          for (var elementFrom in message['messages']) {
            for (var element in listMessage) {
              if (element.id == elementFrom['conversationId']) {
                element.history(MessageModel(
                  text: elementFrom['content'],
                  nameFrom: 'nameFrom',
                  conversationId: elementFrom['conversationId'],
                  senderRegistry: elementFrom['senderId'],
                  isSender: false, // Será redefinido depois
                  timestamp: DateTime.parse(elementFrom['created_at']),
                ));
                break;
              }
            }
          }

          break;
        case 'conversations':
          break;
        case 'error':
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
}
