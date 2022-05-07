import 'package:ecos12_chat_app/app/app_color.dart';
import 'package:flutter/material.dart';

class ButtonCircular extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? colorButton;
  final double radius;
  final double? fontSize;
  final double width;
  final double height;

  const ButtonCircular({
    Key? key,
    required this.text,
    this.onTap,
    this.colorButton,
    this.radius = 25,
    this.fontSize = 20,
    this.width = 250,
    this.height = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: colorButton ?? AppColor.greenTurquoise,
      ),
      width: width,
      height: height,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
