import 'dart:convert';
import 'dart:io';

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
  Future<void> connect(String url) async {
    if (_socket != null) {
      await close();
    }

    _socket = await WebSocket.connect(url);

    send({
      'type': 'Start',
      'id': 'io',
    });
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


/*

var s = await WebSocket.connect('ws://192.168.1.108:3001');
s.add('Start');
s.listen((event) {
  print(event);
});


*/