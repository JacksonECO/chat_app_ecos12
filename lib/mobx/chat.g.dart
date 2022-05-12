// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatStore on _ChatStoreBase, Store {
  Computed<List<ConversationStore>>? _$conversationComputed;

  @override
  List<ConversationStore> get conversation => (_$conversationComputed ??=
          Computed<List<ConversationStore>>(() => super.conversation,
              name: '_ChatStoreBase.conversation'))
      .value;

  late final _$_conversationAtom =
      Atom(name: '_ChatStoreBase._conversation', context: context);

  @override
  ObservableList<ConversationStore> get _conversation {
    _$_conversationAtom.reportRead();
    return super._conversation;
  }

  @override
  set _conversation(ObservableList<ConversationStore> value) {
    _$_conversationAtom.reportWrite(value, super._conversation, () {
      super._conversation = value;
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
  void sendMessage(Map<dynamic, dynamic> data) {
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
conversation: ${conversation}
    ''';
  }
}
