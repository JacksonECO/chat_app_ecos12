import 'package:ecos12_chat_app/app/dot_env_app.dart';
import 'package:ecos12_chat_app/class/date.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';
import 'package:ecos12_chat_app/components/message_user.dart';
import 'package:ecos12_chat_app/mobx/chat.dart';
import 'package:flutter/material.dart';

import 'package:ecos12_chat_app/screen/user/login.dart';
import 'package:get_it/get_it.dart';

void main() {
  throw '''
    For start use "flutter run --target=lib/main_io.dart" or
    "flutter run -d chrome --web-renderer=html --target=lib/main_web.dart
  ''';
}

Future<void> start(WebSocketChat webSocketChat) async {
  DotEnvApp.init();
  await Date.init();

  ChatStore chat = ChatStore(webSocketChat);

  GetIt.I.registerSingleton<ChatStore>(chat);
  GetIt.I.registerSingleton<UserModel>(UserModel());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: MessageUser.scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Chat UNIFEI',
      home: const LoginScreen(),
    );
  }
}
