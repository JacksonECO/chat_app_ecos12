abstract class WebSocketChat {
  static const Duration pingInterval = Duration(seconds: 30);

  bool isWeb = false;

  Future<void> connect([String? url]);

  void listen(void Function(Map<String, dynamic> message) onData);

  Future<void> close();

  void send(Map<String, dynamic> data);
}
