import 'package:ecos12_chat_app/app/app_color.dart';
import 'package:ecos12_chat_app/components/box.dart';
import 'package:ecos12_chat_app/components/button_circular.dart';
import 'package:ecos12_chat_app/components/input_login.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/profile.png',
              height: 375,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitHeight,
            ),
            Box(30),
            const InputTextLogin(title: 'Email', iconData: Icons.email_outlined),
            const InputTextLogin(title: 'Senha', iconData: Icons.key),
            Box(20),
            ButtonCircular(
              colorButton: AppColor.greenTurquoise,
              text: 'Entrar',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
