import 'package:flutter/cupertino.dart';

enum BoxType {
  all,
  horizontal,
  vertical,
}

class Box extends SizedBox {
  const Box(
    double tam, {
    BoxType type = BoxType.all,
    Widget? child,
    Key? key,
  }) : super(
          key: key,
          height: type == BoxType.horizontal ? 0 : tam,
          width: type == BoxType.vertical ? 0 : tam,
          child: child,
        );
}
