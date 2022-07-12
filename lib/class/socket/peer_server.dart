import 'dart:developer';
import 'dart:io';
import 'package:ecos12_chat_app/class/socket/peer_system.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';

class PeerServer extends WebSocketChat {
  RawServerSocket? _server;

  @override
  Future<void> close() async {
    await _server!.close();
    _server = null;
  }

  @override
  Future<void> connect([String? url]) async {
    _server = await RawServerSocket.bind(url!, 3001, shared: true);

    print('Server listening on port ${_server!.port}');
    _server!.listen((RawSocket user) {
      log('New Connection', name: 'Server');
      PeerSystem.addClient(user);
    });
  }

  @override
  void listen(void Function(Map<String, dynamic> message) onData) => Exception('Not implemented');

  @override
  void send(Map<String, dynamic> data) => Exception('Not implemented');
}
