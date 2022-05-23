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
  var registryController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    registryController.dispose();
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
              height: 400,
              width: double.infinity,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitHeight,
            ),
            Box(30),
            InputTextLogin(
              title: 'Matrícula',
              iconData: Icons.how_to_reg,
              controller: registryController,
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
                var loginError =
                    await Login.signIn(registry: registryController.text, password: passwordController.text);
                if (loginError == null) {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) => const ConversationScreen('first')),
                  );
                } else {
                  var snackBar = SnackBar(
                    content: Text(loginError),
                    backgroundColor: Colors.redAccent,
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
