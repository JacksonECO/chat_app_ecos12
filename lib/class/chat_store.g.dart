// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStoreBase, Store {
  Computed<List<ConversationStore>>? _$listMessageComputed;

  @override
  List<ConversationStore> get listMessage => (_$listMessageComputed ??=
          Computed<List<ConversationStore>>(() => super.listMessage,
              name: '_ChatStoreBase.listMessage'))
      .value;

  late final _$_messageStoreAtom =
      Atom(name: '_ChatStoreBase._messageStore', context: context);

  @override
  ObservableList<ConversationStore> get _messageStore {
    _$_messageStoreAtom.reportRead();
    return super._messageStore;
  }

  @override
  set _messageStore(ObservableList<ConversationStore> value) {
    _$_messageStoreAtom.reportWrite(value, super._messageStore, () {
      super._messageStore = value;
    });
  }

  late final _$_socketChatAtom =
      Atom(name: '_ChatStoreBase._socketChat', context: context);

  @override
  WebSocketChat? get _socketChat {
    _$_socketChatAtom.reportRead();
    return super._socketChat;
  }

  @override
  set _socketChat(WebSocketChat? value) {
    _$_socketChatAtom.reportWrite(value, super._socketChat, () {
      super._socketChat = value;
    });
  }

  late final _$startWebSocketAsyncAction =
      AsyncAction('_ChatStoreBase.startWebSocket', context: context);

  @override
  Future<void> startWebSocket() {
    return _$startWebSocketAsyncAction.run(() => super.startWebSocket());
  }

  late final _$closeConnectionAsyncAction =
      AsyncAction('_ChatStoreBase.closeConnection', context: context);

  @override
  Future<void> closeConnection() {
    return _$closeConnectionAsyncAction.run(() => super.closeConnection());
  }

  late final _$_ChatStoreBaseActionController =
      ActionController(name: '_ChatStoreBase', context: context);

  @override
  ConversationStore? getMessage(String idConversation) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.getMessage');
    try {
      return super.getMessage(idConversation);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sendMessage(MessageModel data) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.sendMessage');
    try {
      return super.sendMessage(data);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listMessage: ${listMessage}
    ''';
  }
}
