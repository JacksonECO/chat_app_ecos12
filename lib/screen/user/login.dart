import 'package:ecos12_chat_app/app/app_color.dart';
import 'package:ecos12_chat_app/class/login.dart';
import 'package:ecos12_chat_app/components/box.dart';
import 'package:ecos12_chat_app/components/button_circular.dart';
import 'package:ecos12_chat_app/screen/user/components/input_login.dart';
import 'package:ecos12_chat_app/screen/chat/conversation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/profile.png',
              height: 375,
              width: double.infinity,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitHeight,
            ),
            Box(30),
            InputTextLogin(
              title: 'Email',
              iconData: Icons.email_outlined,
              controller: emailController,
            ),
            InputTextLogin(
              title: 'Senha',
              iconData: Icons.key,
              controller: passwordController,
            ),
            Box(20),
            ButtonCircular(
              colorButton: AppColor.greenTurquoise,
              text: 'Entrar',
              onTap: () async {
                var loginOk = await Login.signIn(registry: emailController.text, password: passwordController.text);
                if (loginOk) {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) => const ConversationScreen()),
                  );
                }
              },
            ),
            Box(20),
          ],
        ),
      ),
    );
  }
}
