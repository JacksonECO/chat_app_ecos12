import 'package:ecos12_chat_app/class/model/message.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';
import 'package:ecos12_chat_app/mobx/conversation.dart';
import 'package:mobx/mobx.dart';
part 'chat.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  _ChatStoreBase(this.typeWebSocketChat) {
    _conversation.add(ConversationStore('first', true));
  }

  late WebSocketChat typeWebSocketChat;

  @observable
  ObservableList<ConversationStore> _conversation = <ConversationStore>[].asObservable();
  @computed
  List<ConversationStore> get listConversation => _conversation.toList();
  @computed
  set conversation(List<ConversationStore> conversation) {
    _conversation = conversation.asObservable();
  }

  @action
  ConversationStore? getConversation(String idConversation) {
    return listConversation.firstWhere((element) => element.id == idConversation, orElse: null);
  }

  @observable
  WebSocketChat? _socketChat;

  @action
  Future<void> startWebSocket() async {
    if (_socketChat != null) await _socketChat!.close();

    _socketChat = typeWebSocketChat;
    await _socketChat!.connect();

    _socketChat!.listen((message) async {
      _conversation.first.addMessage(Message.fromMap(message));
    });
  }

  @action
  void sendMessage(Message data) {
    if (_socketChat == null) print('Sem Conexão');
    _socketChat!.send(data.sendToMap());
  }

  @action
  Future<void> closeConnection() async {
    if (_socketChat == null) return;
    await _socketChat!.close();
  }
}
