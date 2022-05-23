import 'dart:convert';
import 'dart:io';

import 'package:ecos12_chat_app/app/dot_env_app.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';

class WebSocketChatIO implements WebSocketChat {
  WebSocketChatIO();

  WebSocket? _socket;

  @override
  bool isWeb = false;

  @override
  Future<void> close([int? code]) async {
    if (_socket != null) {
      print('Closing connection');
      await _socket!.close(code);
      _socket = null;
    }
  }

  @override
  Future<void> connect([String? url]) async {
    if (_socket != null) {
      await close();
    }

    _socket = await WebSocket.connect(url ?? ('wss://' + DotEnvApp.urlBase)).timeout(const Duration(seconds: 5));

    _socket!.pingInterval = WebSocketChat.pingInterval;

    // send({
    //   'type': 'Start',
    //   'id': 'io',
    // });
  }

  @override
  void listen(void Function(Map<String, dynamic> message) onData) {
    if (_socket == null) throw 'Connect is close';

    _socket!.listen(
      (input) => onData(json.decode(input)),
      onDone: () {
        _socket = null;
        print('Connect closed');
      },
      onError: (a) {
        throw a;
      },
    );
  }

  @override
  void send(Map<String, dynamic> data) {
    if (_socket == null) throw 'Connect is close';
    _socket!.add(json.encode(data));
  }

  @override
  WebSocketChat clone() => WebSocketChatIO();
}
