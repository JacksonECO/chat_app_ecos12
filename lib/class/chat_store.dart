import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';
import 'package:ecos12_chat_app/class/model/message_model.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:mobx/mobx.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  _ChatStoreBase(this.typeWebSocketChat) {
    _messageStore.add(ConversationStore('first', 'Geral', true));
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

    _socketChat!.listen((message) async {
      _messageStore.first.addMessage(MessageModel.fromMap(message));
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
}
