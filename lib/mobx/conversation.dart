import 'package:ecos12_chat_app/class/model/message.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/mobx/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'conversation.g.dart';

class ConversationStore = ConversationStoreBase with _$ConversationStore;

abstract class ConversationStoreBase with Store {
  late String id;

  ConversationStoreBase(this.id);

  @observable
  ScrollController controllerScroll = ScrollController();

  @action
  void upScroll() {
    Future.delayed(const Duration(milliseconds: 200), () {
      controllerScroll.jumpTo(controllerScroll.positions.last.maxScrollExtent);
    });
  }

  @computed
  UserModel get _user => GetIt.instance.get<UserModel>();

  @observable
  ObservableList<Message> _message = <Message>[].asObservable();
  @computed
  List<Message> get message => _message.toList();
  @computed
  set message(List<Message> conversation) {
    _message = conversation.asObservable();
  }

  @action
  void sendOnTap(TextEditingController _controller) {
    if (_controller.text == '') return;
    var temp = Message(text: _controller.text, isSender: true, idFrom: _user.id!, nameFrom: _user.nickname!);
    _controller.text = '';

    var newMessage = temp.toMap();

    addMessage(newMessage);

    newMessage.remove('isSender');
    GetIt.instance.get<ChatStore>().sendMessage(newMessage);
  }

  @action
  void addMessage(Map<String, dynamic> data) {
    var newMessage = Message.fromMap(data);

    newMessage.isSender = _user.id == newMessage.idFrom;

    if (newMessage.isSender == true && newMessage.timestamp != null) {
      for (var i = message.length - 1; i >= 0; i--) {
        if (message[i].text == newMessage.text) {
          _message.removeAt(i);
          break;
        }
      }
    }
    print(newMessage);
    _message.add(newMessage);
    upScroll();
  }
}
