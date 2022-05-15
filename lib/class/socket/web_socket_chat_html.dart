import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';

class WebSocketChatHTML implements WebSocketChat {
  WebSocketChatHTML();

  WebSocket? _socket;

  StreamSubscription<MessageEvent>? _streamSubscription;

  @override
  bool isWeb = true;

  @override
  Future<void> close([int? code]) async {
    if (_socket != null) {
      print('Closing connection');
      await _streamSubscription?.cancel();
      _socket = null;
    }
  }

  @override
  Future<void> connect([String? url]) async {
    if (_socket != null) {
      await close();
    }
    _socket = WebSocket(url ?? ('ws://' + Rest.urlBase));
    bool start = false;

    _socket!.onClose.listen((event) async {
      print('Connect closed');
    });

    var init = _socket!.onOpen.listen((event) {
      // send({
      //   'type': 'Start',
      //   'id': 'html',
      // });
      _startPing();
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

    _streamSubscription = _socket!.onMessage.listen(
      (messageEvent) {
        onData(messageEvent.data);
      },
      onDone: () {
        _socket = null;
        print('Connect closed');
      },
      onError: (a) {
        _socket = null;
        throw a;
      },
    );
  }

  @override
  void send(Map dataStart) {
    if (_socket == null) throw 'Connect is close';
    _socket!.sendString(json.encode(dataStart));
  }

  void _startPing() async {
    while (true) {
      if (_socket == null) return;
      _socket!.sendString('{}');
      await Future.delayed(WebSocketChat.pingInterval);
    }
  }
}
