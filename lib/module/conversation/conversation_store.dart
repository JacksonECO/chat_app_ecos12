import 'dart:developer';

import 'package:ecos12_chat_app/class/chat_store.dart';
import 'package:ecos12_chat_app/class/model/message_model.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'conversation_store.g.dart';

class ConversationStore = ConversationStoreBase with _$ConversationStore;

abstract class ConversationStoreBase with Store {
  String? _id;
  String? get id => _id;

  final String title;
  final bool isGroup;

  ConversationStoreBase(this._id, this.title, this.isGroup);

  @observable
  ScrollController controllerScroll = ScrollController();

  @computed
  UserModel get _user => GetIt.instance.get<UserModel>();

  @computed
  ChatStore get _chat => GetIt.instance.get<ChatStore>();

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
    // listMessage.add(message);
    listMessage.insert(0, message);
    // listMessage.sort(((a, b) {
    //   if (a.timestamp == null && b.timestamp == null) {
    //     if (a.timestampSend!.isBefore(b.timestampSend!)) return 1;
    //     if (a.timestampSend!.isAfter(b.timestampSend!)) return -1;
    //     return 0;
    //   }

    //   if (a.timestamp == null) return -1;
    //   if (b.timestamp == null) return 1;

    //   if (a.timestamp!.isBefore(b.timestamp!)) return 1;
    //   if (a.timestamp!.isAfter(b.timestamp!)) return -1;
    //   return 0;
    // }));
    listMessage = temp;
  }

  @action
  Future<void> sendOnTap(TextEditingController _controller,
      {ConversationStore? thisStore, UserModel? newConversationUser}) async {
    if (_controller.text == '') return;
    if (id == null) {
      if (thisStore == null) throw 'thisStore not found';
      if (newConversationUser == null) throw 'receiver not found';
      final isContinue = await createConversation(thisStore, newConversationUser);
      if (!isContinue) {
        throw 'create conversation failed';
      }
    }
    var newMessage = MessageModel(
      text: _controller.text,
      isSender: true,
      senderRegistry: _user.registry,
      nameFrom: _user.nickname,
      timestampSend: DateTime.now(),
      conversationId: id!,
    );

    // Limpa o campo de texto
    _controller.text = '';

    addMessage(newMessage);
    _chat.sendMessage(newMessage);
  }

  @action
  Future<bool> createConversation(ConversationStore thisStore, UserModel newConversationUser) async {
    try {
      final api = await Rest.post(path: '/conversations', body: {
        'creatorRegistry': _user.registry,
        'title': null,
        'participantsRegistry': [_user.registry, newConversationUser.registry],
      });

      //TODO: retirar esta parte depois de fazer melhoria na rota anterir para retornar o id da conversa
      final listConversation = (await Rest.get(path: '/conversations')) as List<dynamic>;
      _id = listConversation.last['id'];

      _chat.addConversationStore(thisStore);

      return true;
    } catch (e, s) {
      log('Failure create conversation', name: 'Conversation', error: e, stackTrace: s);
      return false;
    }
  }

  @action
  void addMessage(MessageModel newMessage) {
    newMessage.isSender = _user.registry == newMessage.senderRegistry;

    /// Para quando é recebido a confirmação de envio da mensagem
    if (newMessage.isSender == true && newMessage.timestamp != null) {
      for (var i = 0; i < listMessage.length; i++) {
        if (listMessage[i].text == newMessage.text && listMessage[i].senderRegistry == newMessage.senderRegistry) {
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
  void history(MessageModel newMessage) {
    newMessage.isSender = _user.registry == newMessage.senderRegistry;

    addAndOrderByMessage(newMessage);
  }

  @action
  void upScroll() {
    Future.delayed(const Duration(milliseconds: 200), () {
      controllerScroll.jumpTo(0);
    });
  }
}
