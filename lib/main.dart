import 'package:ecos12_chat_app/app/dot_env_app.dart';
import 'package:ecos12_chat_app/class/date.dart';
import 'package:ecos12_chat_app/class/socket/web_socket_chat.dart';
import 'package:ecos12_chat_app/class/chat_store.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/module/user/login_screen.dart';
import 'package:ecos12_chat_app/widgets/message_user.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

void main() {
  throw '''
    For start use "flutter run --target=lib/main_io.dart" or
    "flutter run -d chrome --web-renderer=html --target=lib/main_web.dart
  ''';
}

Future<void> start(WebSocketChat webSocketChat) async {
  DotEnvApp.init();
  Date.init();

  GetIt.I.registerSingleton<ChatStore>(ChatStore(webSocketChat));
  GetIt.I.registerSingleton<UserModel>(UserModel.init());

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
