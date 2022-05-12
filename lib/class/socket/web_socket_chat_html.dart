import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';

class WebSocketChatHTML implements WebSocketChat {
  WebSocketChatHTML();

  WebSocket? _socket;

  @override
  bool isWeb = true;

  @override
  Future<void> close([int? code]) async {
    //! Web não funcional
    // if (_socket != null) {
    //   _socket!.close(code);
    //   _socket = null;
    // }
  }

  @override
  Future<void> connect(String url) async {
    if (_socket != null) {
      await close();
    }
    _socket = WebSocket(url);
    bool start = false;

    _socket!.onClose.listen((event) {
      print('Servidor Caiu');
    });

    var init = _socket!.onOpen.listen((event) {
      send({
        'type': 'Start',
        'id': 'html',
      });
      start = true;
    });

    for (int i = 0; i < 10 * 5; i++) {
      if (start) return init.cancel();
      await Future.delayed(const Duration(milliseconds: 100));
    }
    await init.cancel();
    throw 'Timeout connect of 5 seconds';
  }

  @override
  void listen(void Function(dynamic message) onData) {
    if (_socket == null) throw 'Connect is close';

    _socket!.onMessage.listen(
      (messageEvent) {
        onData(messageEvent.data);
      },
      onDone: () {
        _socket = null;
        print('Connect closed');
      },
      onError: (a) {
        throw a;
      },
    );
    MessageEvent a;
  }

  @override
  void send(Map dataStart) {
    if (_socket == null) throw 'Connect is close';
    _socket!.sendString(json.encode(dataStart));
  }
}