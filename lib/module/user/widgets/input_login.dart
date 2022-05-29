import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextLogin extends StatelessWidget {
  // Obrigatórios
  final String title;

  // Recomendados
  final void Function(String)? onChanged;
  final String? initialValue;
  final String? hintText;
  final IconData? iconData;

  // Opcionais com default
  final double paddingHorizontal;
  final double paddingVertical;
  final bool obscureText;

  // Opcionais sem default
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;

  /// InputText para o login e cadastro de usuários
  const InputTextLogin({
    Key? key,
    required this.title,
    this.onChanged,
    this.initialValue,
    this.hintText,
    this.iconData,
    this.paddingHorizontal = 50,
    this.paddingVertical = 20,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(color: ColorApp.greenTurquoise),
            ),
          ),
          TextFormField(
            controller: controller,
            initialValue: initialValue,
            onChanged: onChanged,
            obscureText: obscureText,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(
                iconData,
                color: ColorApp.lightPeriwinkle,
              ),
              focusColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
