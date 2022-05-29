import 'package:ecos12_chat_app/app/color_app.dart';
import 'package:flutter/material.dart';

enum StatusMessageUser {
  message,
  error,
  success,
}

extension MessageUserStatusExtension on StatusMessageUser {
  String get name {
    switch (this) {
      case StatusMessageUser.message:
        return 'Message';
      case StatusMessageUser.error:
        return 'Error';
      case StatusMessageUser.success:
        return 'Success';
    }
  }

  Color get backgroundColor {
    switch (this) {
      case StatusMessageUser.message:
        return Colors.black;
      case StatusMessageUser.error:
        return Colors.red;
      case StatusMessageUser.success:
        return ColorApp.greenTurquoise;
    }
  }

  Color get colorText {
    switch (this) {
      case StatusMessageUser.message:
        return Colors.white;
      case StatusMessageUser.error:
        return Colors.white;
      case StatusMessageUser.success:
        return Colors.white;
    }
  }
}
