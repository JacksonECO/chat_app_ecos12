import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:ecos12_chat_app/module/home/home_screen.dart';
import 'package:ecos12_chat_app/module/user/class/login.dart';
import 'package:ecos12_chat_app/module/user/register_screen.dart';
import 'package:ecos12_chat_app/module/user/widgets/input_login.dart';
import 'package:ecos12_chat_app/widgets/box.dart';
import 'package:ecos12_chat_app/widgets/button_circular.dart';
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
              colorButton: ColorApp.greenTurquoise,
              text: 'Entrar',
              onTap: () async {
                final success = await Login.signIn(
                  registry: registryController.text,
                  password: passwordController.text,
                );

                if (success) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute<void>(builder: (BuildContext context) => const HomeScreen()),
                    (Route<dynamic> route) => false,
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
                  color: ColorApp.azure,
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
