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

  late final _$ConversationStoreBaseActionController =
      ActionController(name: 'ConversationStoreBase', context: context);

  @override
  void addAndOrderByMessage(MessageModel message) {
    final _$actionInfo = _$ConversationStoreBaseActionController.startAction(
        name: 'ConversationStoreBase.addAndOrderByMessage');
    try {
      return super.addAndOrderByMessage(message);
    } finally {
      _$ConversationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendOnTap(TextEditingController _controller) {
    final _$actionInfo = _$ConversationStoreBaseActionController.startAction(
        name: 'ConversationStoreBase.sendOnTap');
    try {
      return super.sendOnTap(_controller);
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
controllerScroll: ${controllerScroll},
listMessage: ${listMessage},
lastMessage: ${lastMessage}
    ''';
  }
}
