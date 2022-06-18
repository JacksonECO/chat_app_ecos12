import 'package:ecos12_chat_app/widgets/button_simple.dart';
import 'package:flutter/material.dart';

class MenuItens extends PopupMenuItem {
  MenuItens({
    super.key,
    void Function()? onTap,
    IconData? icon,
    required String text,
  }) : super(
          child: Builder(builder: (context) {
            return ButtonSimple(
              onTap: () {
                Navigator.pop(context);
                if (onTap != null) onTap();
              },
              child: Row(
                children: [
                  Icon(icon, color: Colors.black),
                  const SizedBox(width: 20),
                  Text(text),
                ],
              ),
            );
          }),
        );
}
