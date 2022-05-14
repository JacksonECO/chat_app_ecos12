import 'dart:convert';
import 'dart:io';

import 'package:ecos12_chat_app/class/rest.dart';
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

    _socket = await WebSocket.connect(url ?? ('ws://' + Rest.urlBase)).timeout(const Duration(seconds: 5));

    // send({
    //   'type': 'Start',
    //   'id': 'io',
    // });
  }

  @override
  void listen(void Function(dynamic message) onData) {
    if (_socket == null) throw 'Connect is close';

    _socket!.listen(
      onData,
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
  void send(Map data) {
    if (_socket == null) throw 'Connect is close';
    _socket!.add(json.encode(data));
  }
}
