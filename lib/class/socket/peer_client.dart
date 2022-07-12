import 'dart:convert';
import 'dart:io';

import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/socket/peer_system.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';
import 'package:get_it/get_it.dart';

class PeerClient extends WebSocketChat {
  @override
  Future<void> close() async => Exception('Not implemented');

  @override
  Future<void> connect([String? url, String? registry, String? token]) async {
    print(url);
    final socket = await RawSocket.connect(url!, 3001);
    print(url);

    PeerSystem.addServer(socket, registry!);

    socket.write(jsonEncode({
      'type': 'sync',
      'peerRegistry': GetIt.instance.get<UserModel>().registry,
      'token': token!,
    }).codeUnits);
  }

  @override
  void listen(void Function(Map<String, dynamic> message) onData) => Exception('Not implemented');

  @override
  void send(Map<String, dynamic> data) => Exception('Not implemented');
}
