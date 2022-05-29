import 'package:ecos12_chat_app/class/chat_store.dart';
import 'package:ecos12_chat_app/class/model/message_model.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'conversation_store.g.dart';

class ConversationStore = ConversationStoreBase with _$ConversationStore;

abstract class ConversationStoreBase with Store {
  final String id;
  final String title;
  final bool isGroup;

  ConversationStoreBase(this.id, this.title, this.isGroup);

  @observable
  ScrollController controllerScroll = ScrollController();

  @computed
  UserModel get _user => GetIt.instance.get<UserModel>();

  @observable
  ObservableList<MessageModel> _listMessage = <MessageModel>[].asObservable();
  @computed
  List<MessageModel> get listMessage => _listMessage.toList();
  @computed
  set listMessage(List<MessageModel> messageStore) {
    _listMessage = messageStore.asObservable();
  }

  @computed
  MessageModel? get lastMessage {
    return listMessage.isNotEmpty ? listMessage.first : null;
  }

  @action
  void addAndOrderByMessage(MessageModel message) {
    var temp = listMessage;
    listMessage.add(message);
    listMessage.sort(((a, b) {
      if (a.timestamp == null && b.timestamp == null) {
        if (a.timestampSend!.isBefore(b.timestampSend!)) return 1;
        if (a.timestampSend!.isAfter(b.timestampSend!)) return -1;
        return 0;
      }

      if (a.timestamp == null) return -1;
      if (b.timestamp == null) return 1;

      if (a.timestamp!.isBefore(b.timestamp!)) return 1;
      if (a.timestamp!.isAfter(b.timestamp!)) return -1;
      return 0;
    }));
    listMessage = temp;
  }

  @action
  void sendOnTap(TextEditingController _controller) {
    if (_controller.text == '') return;
    var newMessage = MessageModel(
      text: _controller.text,
      isSender: true,
      idFrom: _user.id!,
      nameFrom: _user.nickname!,
      timestampSend: DateTime.now(),
    );

    // Limpa o campo de texto
    _controller.text = '';

    addMessage(newMessage);
    GetIt.instance.get<ChatStore>().sendMessage(newMessage);
  }

  @action
  void addMessage(MessageModel newMessage) {
    newMessage.isSender = _user.id == newMessage.idFrom;

    /// Para quando é recebido a confirmação de envio da mensagem
    if (newMessage.isSender == true && newMessage.timestamp != null) {
      for (var i = 0; i < listMessage.length; i++) {
        if (listMessage[i].text == newMessage.text && listMessage[i].idFrom == newMessage.idFrom) {
          _listMessage.remove(listMessage[i]);
          break;
        }
      }
    }

    print(newMessage);
    addAndOrderByMessage(newMessage);
    upScroll();
  }

  @action
  void upScroll() {
    Future.delayed(const Duration(milliseconds: 200), () {
      controllerScroll.jumpTo(0);
    });
  }
}
