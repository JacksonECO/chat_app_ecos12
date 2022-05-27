import 'package:ecos12_chat_app/app/app_color.dart';
import 'package:ecos12_chat_app/screen/user/class/login.dart';
import 'package:ecos12_chat_app/components/box.dart';
import 'package:ecos12_chat_app/components/button_circular.dart';
import 'package:ecos12_chat_app/screen/user/components/input_login.dart';
import 'package:ecos12_chat_app/screen/chat/conversation.dart';
import 'package:ecos12_chat_app/screen/user/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            Box(15),
            InputTextLogin(
              title: 'Matrícula',
              iconData: Icons.how_to_reg,
              controller: registryController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            InputTextLogin(
              title: 'Senha',
              iconData: Icons.key,
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            Box(20),
            ButtonCircular(
              colorButton: AppColor.greenTurquoise,
              text: 'Entrar',
              onTap: () async {
                final success = await Login.signIn(
                  registry: registryController.text,
                  password: passwordController.text,
                );

                if (success) {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) => const ConversationScreen('first')),
                  );
                }
              },
            ),
            Box(20),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (BuildContext context) => const RegisterScreen()),
                );
              },
              child: const Text(
                'Inscreva-se',
                style: TextStyle(
                  color: AppColor.azure,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
            ),
            Box(20),
          ],
        ),
      ),
    );
  }
}
