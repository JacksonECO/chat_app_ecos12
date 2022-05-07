import 'package:flutter/cupertino.dart';

enum BoxType {
  all,
  horizontal,
  vertical,
}

class Box extends SizedBox {
  final double tam;
  final BoxType type;

  const Box(
    this.tam, [
    this.type = BoxType.all,
    Key? key,
  ]) : super(
          key: key,
          height: type == BoxType.horizontal ? 0 : tam,
          width: type == BoxType.vertical ? 0 : tam,
        );
}
