import 'package:ecos12_chat_app/app/app_exception.dart';
import 'package:ecos12_chat_app/components/message_user_status.dart';
import 'package:flutter/material.dart';

export 'package:ecos12_chat_app/components/message_user_status.dart';

abstract class MessageUser {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackBar(
    String message, {
    StatusMessageUser status = StatusMessageUser.message,
    Duration time = const Duration(seconds: 4),
  }) {
    print('SnackBar: $message');
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: status.colorText),
        ),
        backgroundColor: status.backgroundColor,
        duration: time,
      ),
    );
  }

  static bool exceptionSnackBar(
    Object object, {
    Duration time = const Duration(seconds: 4),
  }) {
    String message = AppException.messageDefault;

    if (object is AppException) {
      message = object.message;
    } else if (object is Exception) {
      message = object.toString();
    } else if (object is String) {
      message = object;
    }

    print('ExceptionSnackBar: $object');
    scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: StatusMessageUser.error.colorText),
        ),
        backgroundColor: StatusMessageUser.error.backgroundColor,
        duration: time,
      ),
    );
    return false;
  }
}
