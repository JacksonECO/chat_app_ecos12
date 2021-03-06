import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ecos12_chat_app/app/dot_env_app.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';

class WebSocketChatIO implements WebSocketChat {
  WebSocketChatIO();

  WebSocket? _socket;

  @override
  bool isWeb = false;

  @override
  Future<void> close() async {
    if (_socket != null) {
      print('Closing connection');
      await _socket!.close();
      _socket = null;
    }
  }

  @override
  Future<void> connect([String? url]) async {
    if (_socket != null) {
      await close();
    }

    _socket = await WebSocket.connect(url ?? ('wss://' + DotEnvApp.urlBase));

    _socket!.pingInterval = WebSocketChat.pingInterval;
  }

  @override
  void listen(void Function(Map<String, dynamic> message) onData) {
    if (_socket == null) throw 'Connect is close';

    _socket!.listen(
      (input) {
        if (input is String) {
          log(input, name: 'Server');
          onData(json.decode(input));
        }else{
          log(input, name: '_Server');
        }
      },
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
    log(json.encode(data), name: 'Client');
    _socket!.add(json.encode(data));
  }

}
