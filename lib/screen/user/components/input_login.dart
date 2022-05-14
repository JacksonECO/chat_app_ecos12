import 'package:flutter/material.dart';

import 'package:ecos12_chat_app/app/app_color.dart';

class InputTextLogin extends StatelessWidget {
  final String title;

  final void Function(String)? onChanged;
  final String? initialValue;
  final String? hintText;
  final IconData? iconData;

  final double paddingHorizontal;
  final double paddingVertical;

  final TextEditingController? controller;

  const InputTextLogin({
    Key? key,
    required this.title,
    this.onChanged,
    this.initialValue,
    this.hintText,
    this.iconData,
    this.paddingHorizontal = 50,
    this.paddingVertical = 20,
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
              style: TextStyle(color: AppColor.greenTurquoise),
            ),
          ),
          TextFormField(
            controller: controller,
            initialValue: initialValue,
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(
                  iconData,
                  color: AppColor.lightPeriwinkle,
                ),
                focusColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
