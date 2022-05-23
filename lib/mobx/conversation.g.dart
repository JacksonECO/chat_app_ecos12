// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

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
  Computed<List<Message>>? _$listMessageComputed;

  @override
  List<Message> get listMessage => (_$listMessageComputed ??=
          Computed<List<Message>>(() => super.listMessage,
              name: 'ConversationStoreBase.listMessage'))
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
  ObservableList<Message> get _listMessage {
    _$_listMessageAtom.reportRead();
    return super._listMessage;
  }

  @override
  set _listMessage(ObservableList<Message> value) {
    _$_listMessageAtom.reportWrite(value, super._listMessage, () {
      super._listMessage = value;
    });
  }

  late final _$ConversationStoreBaseActionController =
      ActionController(name: 'ConversationStoreBase', context: context);

  @override
  void addAndOrderByMessage(Message message) {
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
  void addMessage(Message newMessage) {
    final _$actionInfo = _$ConversationStoreBaseActionController.startAction(
        name: 'ConversationStoreBase.addMessage');
    try {
      return super.addMessage(newMessage);
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
listMessage: ${listMessage}
    ''';
  }
}
