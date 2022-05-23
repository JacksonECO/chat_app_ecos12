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
  Computed<List<Message>>? _$messageComputed;

  @override
  List<Message> get message =>
      (_$messageComputed ??= Computed<List<Message>>(() => super.message,
              name: 'ConversationStoreBase.message'))
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

  late final _$_messageAtom =
      Atom(name: 'ConversationStoreBase._message', context: context);

  @override
  ObservableList<Message> get _message {
    _$_messageAtom.reportRead();
    return super._message;
  }

  @override
  set _message(ObservableList<Message> value) {
    _$_messageAtom.reportWrite(value, super._message, () {
      super._message = value;
    });
  }

  late final _$ConversationStoreBaseActionController =
      ActionController(name: 'ConversationStoreBase', context: context);

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
  void orderByMessage() {
    final _$actionInfo = _$ConversationStoreBaseActionController.startAction(
        name: 'ConversationStoreBase.orderByMessage');
    try {
      return super.orderByMessage();
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
  String toString() {
    return '''
controllerScroll: ${controllerScroll},
message: ${message}
    ''';
  }
}
