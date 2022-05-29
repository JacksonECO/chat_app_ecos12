import 'package:flutter/material.dart';

class ButtonSimple extends InkWell {
  const ButtonSimple({
    super.key,
    super.child,
    super.onTap,
  }) : super(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        );
}
