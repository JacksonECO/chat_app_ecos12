import 'package:ecos12_chat_app/components/box.dart';
import 'package:ecos12_chat_app/components/button_circular.dart';
import 'package:ecos12_chat_app/screen/chat/conversation.dart';
import 'package:ecos12_chat_app/screen/user/class/register.dart';
import 'package:ecos12_chat_app/screen/user/components/design_register_top.dart';
import 'package:ecos12_chat_app/screen/user/components/input_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _registryController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _registryController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Box(120),
              InputTextLogin(
                title: 'Nome',
                controller: _nameController,
                hintText: 'Digite seu nome',
                iconData: Icons.person,
                keyboardType: TextInputType.name,
              ),
              InputTextLogin(
                title: 'Matrícula',
                controller: _registryController,
                hintText: 'Digite sua matrícula',
                iconData: Icons.how_to_reg,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              InputTextLogin(
                title: 'Senha',
                controller: _passwordController,
                hintText: 'Digite sua senha',
                iconData: Icons.key,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              InputTextLogin(
                title: 'Confirmar senha',
                controller: _passwordConfirmController,
                hintText: 'Digite sua senha novamente',
                iconData: Icons.key,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
              Box(50),
              ButtonCircular(
                height: 45,
                width: 220,
                text: 'Cadastrar',
                onTap: () async {
                  final success = await Register.call(
                    name: _nameController.text,
                    registry: _registryController.text,
                    password: _passwordController.text,
                    passwordConfirm: _passwordConfirmController.text,
                  );

                  if (success) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(builder: (BuildContext context) => const ConversationScreen('first')),
                      // (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        const DesignRegisterTop(),
      ]),
    );
  }
}
