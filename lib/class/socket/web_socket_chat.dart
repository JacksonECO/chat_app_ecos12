abstract class WebSocketChat {
  factory WebSocketChat(WebSocketChat webSocketChat) {
    // return WebSocketChatHTML();
    // return WebSocketChatIO();
    return webSocketChat;
  }

  late bool isWeb;

  Future<void> connect(String url);

  void listen(void Function(dynamic message) onData);

  Future<void> close([int? code]);

  void send(Map data);
}
