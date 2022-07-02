import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:ecos12_chat_app/app/dot_env_app.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';

class WebSocketChatHTML implements WebSocketChat {
  WebSocketChatHTML();

  WebSocket? _socket;

  StreamSubscription<MessageEvent>? _streamSubscription;

  @override
  bool isWeb = true;

  @override
  Future<void> close() async {
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
    _socket = WebSocket(url ?? ('wss://' + DotEnvApp.urlBase));
    bool start = false;

    _socket!.onClose.listen((event) async {
      print('Connect closed');
      await close();
    });

    var init = _socket!.onOpen.listen((event) {
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
  void listen(void Function(Map<String, dynamic> message) onData) {
    if (_socket == null) throw 'Connect is close';

    _streamSubscription = _socket!.onMessage.listen(
      (messageEvent) {
        if (messageEvent.data is String) {
          log(messageEvent.data, name: 'Server');
          onData(json.decode(messageEvent.data));
        } else {
          log(messageEvent.data, name: '_Server');
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
  void send(Map<String, dynamic> dataStart) {
    if (_socket == null) throw 'Connect is close';
    log(json.encode(dataStart), name: 'Client');
    _socket!.sendString(json.encode(dataStart));
  }

  void _startPing() async {
    while (true) {
      if (_socket == null) return;
      await Future.delayed(WebSocketChat.pingInterval);
      _socket!.sendString('{}');
    }
  }
}
