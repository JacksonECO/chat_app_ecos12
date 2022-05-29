// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessageStore on MessageStoreBase, Store {
  Computed<UserModel>? _$_userComputed;

  @override
  UserModel get _user =>
      (_$_userComputed ??= Computed<UserModel>(() => super._user,
              name: 'MessageStoreBase._user'))
          .value;
  Computed<List<MessageModel>>? _$listMessageComputed;

  @override
  List<MessageModel> get listMessage => (_$listMessageComputed ??=
          Computed<List<MessageModel>>(() => super.listMessage,
              name: 'MessageStoreBase.listMessage'))
      .value;

  late final _$controllerScrollAtom =
      Atom(name: 'MessageStoreBase.controllerScroll', context: context);

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
      Atom(name: 'MessageStoreBase._listMessage', context: context);

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

  late final _$MessageStoreBaseActionController =
      ActionController(name: 'MessageStoreBase', context: context);

  @override
  void addAndOrderByMessage(MessageModel message) {
    final _$actionInfo = _$MessageStoreBaseActionController.startAction(
        name: 'MessageStoreBase.addAndOrderByMessage');
    try {
      return super.addAndOrderByMessage(message);
    } finally {
      _$MessageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendOnTap(TextEditingController _controller) {
    final _$actionInfo = _$MessageStoreBaseActionController.startAction(
        name: 'MessageStoreBase.sendOnTap');
    try {
      return super.sendOnTap(_controller);
    } finally {
      _$MessageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addMessage(MessageModel newMessage) {
    final _$actionInfo = _$MessageStoreBaseActionController.startAction(
        name: 'MessageStoreBase.addMessage');
    try {
      return super.addMessage(newMessage);
    } finally {
      _$MessageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void upScroll() {
    final _$actionInfo = _$MessageStoreBaseActionController.startAction(
        name: 'MessageStoreBase.upScroll');
    try {
      return super.upScroll();
    } finally {
      _$MessageStoreBaseActionController.endAction(_$actionInfo);
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
