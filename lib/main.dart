import 'package:flutter/material.dart';

import 'package:ecos12_chat_app/screen/user/login.dart';

void main() {
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
