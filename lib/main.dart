import 'package:ecos12_chat_app/class/socket/web_socket_chat_io.dart';
import 'package:ecos12_chat_app/mobx/chat.dart';
import 'package:flutter/material.dart';

import 'package:ecos12_chat_app/screen/user/login.dart';
import 'package:get_it/get_it.dart';

Future<void> main() async {
  ChatStore chat = ChatStore(WebSocketChatIO());
  // ChatStore chat = ChatStore(WebSocketChatHTML());

  GetIt.I.registerSingleton<ChatStore>(chat);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Chat UNIFEI',
      home: LoginScreen(),
    );
  }
}
