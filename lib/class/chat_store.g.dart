// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStoreBase, Store {
  Computed<List<ConversationStore>>? _$listConversationComputed;

  @override
  List<ConversationStore> get listConversation =>
      (_$listConversationComputed ??= Computed<List<ConversationStore>>(
              () => super.listConversation,
              name: '_ChatStoreBase.listConversation'))
          .value;

  late final _$_conversationStoreAtom =
      Atom(name: '_ChatStoreBase._conversationStore', context: context);

  @override
  ObservableList<ConversationStore> get _conversationStore {
    _$_conversationStoreAtom.reportRead();
    return super._conversationStore;
  }

  @override
  set _conversationStore(ObservableList<ConversationStore> value) {
    _$_conversationStoreAtom.reportWrite(value, super._conversationStore, () {
      super._conversationStore = value;
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
  void addConversationStore(ConversationStore conversationStore) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.addConversationStore');
    try {
      return super.addConversationStore(conversationStore);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ConversationStore? getConversation(String idConversation) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.getConversation');
    try {
      return super.getConversation(idConversation);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanConversation() {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.cleanConversation');
    try {
      return super.cleanConversation();
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
listConversation: ${listConversation}
    ''';
  }
}
