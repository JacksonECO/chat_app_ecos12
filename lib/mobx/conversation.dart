import 'package:ecos12_chat_app/class/model/message.dart';
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
    var temp = Message(
      text: _controller.text,
      date: DateTime.now(),
      isSender: true,
    );
    _message.add(temp);
    _controller.text = '';
    print(_message.last.toJson());
    GetIt.instance.get<ChatStore>().sendMessage(temp.toMap());
  }

  @action
  void addMessage(String data) {
    print(_message);
    print(data);
    _message.add(Message.fromJson(data));
  }
}
