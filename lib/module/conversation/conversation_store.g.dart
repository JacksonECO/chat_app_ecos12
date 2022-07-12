// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConversationStore on ConversationStoreBase, Store {
  Computed<UserModel>? _$_userComputed;

  @override
  UserModel get _user =>
      (_$_userComputed ??= Computed<UserModel>(() => super._user,
              name: 'ConversationStoreBase._user'))
          .value;
  Computed<ChatStore>? _$_chatComputed;

  @override
  ChatStore get _chat =>
      (_$_chatComputed ??= Computed<ChatStore>(() => super._chat,
              name: 'ConversationStoreBase._chat'))
          .value;
  Computed<List<MessageModel>>? _$listMessageComputed;

  @override
  List<MessageModel> get listMessage => (_$listMessageComputed ??=
          Computed<List<MessageModel>>(() => super.listMessage,
              name: 'ConversationStoreBase.listMessage'))
      .value;
  Computed<MessageModel?>? _$lastMessageComputed;

  @override
  MessageModel? get lastMessage => (_$lastMessageComputed ??=
          Computed<MessageModel?>(() => super.lastMessage,
              name: 'ConversationStoreBase.lastMessage'))
      .value;

  late final _$titleAtom =
      Atom(name: 'ConversationStoreBase.title', context: context);

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$secretRegistryAtom =
      Atom(name: 'ConversationStoreBase.secretRegistry', context: context);

  @override
  String? get secretRegistry {
    _$secretRegistryAtom.reportRead();
    return super.secretRegistry;
  }

  @override
  set secretRegistry(String? value) {
    _$secretRegistryAtom.reportWrite(value, super.secretRegistry, () {
      super.secretRegistry = value;
    });
  }

  late final _$controllerScrollAtom =
      Atom(name: 'ConversationStoreBase.controllerScroll', context: context);

  @override
  ScrollController get controllerScroll {
    _$controllerScrollAtom.reportRead();
    return super.controllerScroll;
  }

  @override
  set controllerScroll(ScrollController value) {
    _$controllerScrollAtom.reportWrite(value, super.controllerScroll, () {
      super.controllerScroll = value;
    });
  }

  late final _$_listMessageAtom =
      Atom(name: 'ConversationStoreBase._listMessage', context: context);

  @override
  ObservableList<MessageModel> get _listMessage {
    _$_listMessageAtom.reportRead();
    return super._listMessage;
  }

  @override
  set _listMessage(ObservableList<MessageModel> value) {
    _$_listMessageAtom.reportWrite(value, super._listMessage, () {
      super._listMessage = value;
    });
  }

  late final _$sendOnTapAsyncAction =
      AsyncAction('ConversationStoreBase.sendOnTap', context: context);

  @override
  Future<void> sendOnTap(TextEditingController _controller,
      {ConversationStore? thisStore, UserModel? newConversationUser}) {
    return _$sendOnTapAsyncAction.run(() => super.sendOnTap(_controller,
        thisStore: thisStore, newConversationUser: newConversationUser));
  }

  late final _$createConversationAsyncAction =
      AsyncAction('ConversationStoreBase.createConversation', context: context);

  @override
  Future<bool> createConversation(
      ConversationStore thisStore, List<UserModel> newConversationUser,
      [String? title]) {
    return _$createConversationAsyncAction.run(
        () => super.createConversation(thisStore, newConversationUser, title));
  }

  late final _$ConversationStoreBaseActionController =
      ActionController(name: 'ConversationStoreBase', context: context);

  @override
  void _addAndOrderByMessage(MessageModel message) {
    final _$actionInfo = _$ConversationStoreBaseActionController.startAction(
        name: 'ConversationStoreBase._addAndOrderByMessage');
    try {
      return super._addAndOrderByMessage(message);
    } finally {
      _$ConversationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMessage(MessageModel newMessage) {
    final _$actionInfo = _$ConversationStoreBaseActionController.startAction(
        name: 'ConversationStoreBase.addMessage');
    try {
      return super.addMessage(newMessage);
    } finally {
      _$ConversationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void history(MessageModel newMessage) {
    final _$actionInfo = _$ConversationStoreBaseActionController.startAction(
        name: 'ConversationStoreBase.history');
    try {
      return super.history(newMessage);
    } finally {
      _$ConversationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void upScroll() {
    final _$actionInfo = _$ConversationStoreBaseActionController.startAction(
        name: 'ConversationStoreBase.upScroll');
    try {
      return super.upScroll();
    } finally {
      _$ConversationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
secretRegistry: ${secretRegistry},
controllerScroll: ${controllerScroll},
listMessage: ${listMessage},
lastMessage: ${lastMessage}
    ''';
  }
}
