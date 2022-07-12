import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:ecos12_chat_app/class/chat_store.dart';
import 'package:ecos12_chat_app/class/model/message_model.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/class/user_name.dart';
import 'package:ecos12_chat_app/module/conversation/conversation_store.dart';
import 'package:get_it/get_it.dart';

abstract class PeerSystem {
  static final List<Map<String, dynamic>> _list = [];

  static void addClient(RawSocket socket) {
    List _cache = [];
    bool start = false;
    final int id = _list.length;

    _list.add({
      'socket': socket,
      'start': start,
    });

    socket.listen((RawSocketEvent event) async {
      switch (event) {
        case RawSocketEvent.closed:
          log(RawSocketEvent.closed.toString(), name: 'PeerServer');
          break;
        case RawSocketEvent.read:
          Uint8List? int8 = socket.read();
          if (int8 != null) {
            var string = String.fromCharCodes(int8);
            var map = jsonDecode(string);

            log(string, name: 'PeerServer/Read');

            if (map['type'] == 'sync' && !start) {
              start = await _configUser(map, id);
              if (start) {
                _list[id]['start'] = true;

                for (int i = 0; i < _cache.length; i++) {
                  _actionLister(_cache[i], _list[id]);
                }
                _cache.clear();
              }
            } else if (start) {
              _actionLister(map, _list[id]);
            } else {
              _cache.add(map);
            }
          }
          break;
        case RawSocketEvent.readClosed:
          log(RawSocketEvent.readClosed.toString(), name: 'PeerServer');
          break;
        case RawSocketEvent.write:
          log(RawSocketEvent.write.toString(), name: 'PeerServer');
          break;
      }
    });
  }

  static void addServer(RawSocket socket, String registry) {
    final int id = _list.length;

    _list.add({
      'socket': socket,
      'start': true,
      'peerRegistry': registry,
    });

    socket.listen((RawSocketEvent event) {
      switch (event) {
        case RawSocketEvent.closed:
          log(RawSocketEvent.closed.toString(), name: 'PeerClient');
          break;
        case RawSocketEvent.read:
          Uint8List? int8 = socket.read();
          if (int8 != null) {
            var string = String.fromCharCodes(int8);
            var map = jsonDecode(string);

            log(string, name: 'PeerClient/Read');
            _actionLister(map, _list[id]);
          }
          break;
        case RawSocketEvent.readClosed:
          log(RawSocketEvent.readClosed.toString(), name: 'PeerClient');
          break;
        case RawSocketEvent.write:
          log(RawSocketEvent.write.toString(), name: 'PeerClient');
          break;
      }
    });
  }

  static Future<bool> _configUser(Map<String, dynamic> map, int id) async {
    try {
      final save = _list[id];
      if (map['peerRegistry'] == null) return false;

      save['peerRegistry'] = map['peerRegistry'];
      await Rest.post(path: '/peer-to-peer', body: {
        'registry': map['peerRegistry'],
        'token': map['token'],
      });
    } catch (_) {
      return false;
    }
    return true;
  }

  static void send(Map<String, dynamic> data, String registry) {
    getSocketByRegistry(registry)?.write(jsonEncode(data).codeUnits);
  }

  static Future<void> _actionLister(Map<String, dynamic> data, Map<String, dynamic> socket) async {
    final chat = GetIt.instance.get<ChatStore>();

    switch (data['type']) {
      case 'message':
        final conversationId = data['conversationId'] == 'secret:${GetIt.instance.get<UserModel>().registry}'
            ? 'secret:${data['senderRegistry']}'
            : data['conversationId'];

        final conversation = chat.getConversation(conversationId);
        if (conversation != null) {
          conversation.addMessage(MessageModel.fromMap(data));
        } else {
          chat.addConversationStore(
            ConversationStore(
              conversationId,
              'Privado: ...',
              false,
            )..addMessage(MessageModel.fromMap(data)),
          );

          UserName.byRegistry(data['senderRegistry']).then((value) {
            chat.getConversation(conversationId)!.title = 'Privado: $value';
          });
        }
        send({
          ...data,
          'type': 'message_confirm',
        }, data['senderRegistry']);

        break;

      case 'message_confirm':
        final conversationId = data['conversationId'] == 'secret:${GetIt.instance.get<UserModel>().registry}'
            ? 'secret:${data['senderRegistry']}'
            : data['conversationId'];
        final conversation = chat.getConversation(conversationId);
        if (conversation != null) {
          conversation.addMessage(MessageModel.fromMap(data));
        }
        break;
    }
  }

  static RawSocket? getSocketByRegistry(String registry) {
    for (var element in _list) {
      if (element['peerRegistry'] == registry) {
        return element['socket'] as RawSocket;
      }
    }
    return null;
  }
}
