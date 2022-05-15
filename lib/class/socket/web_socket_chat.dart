abstract class WebSocketChat {
  static const Duration pingInterval = Duration(seconds: 30);

  late bool isWeb;

  Future<void> connect([String? url]);

  void listen(void Function(dynamic message) onData);

  Future<void> close([int? code]);

  void send(Map data);
}
