import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/module/user/class/user_exception.dart';
import 'package:ecos12_chat_app/widgets/message_user.dart';
import 'package:get_it/get_it.dart';

abstract class Login {
  static Future<bool> signIn({required String registry, required String password}) async {
    try {
      final response = await Rest.post(
        path: '/login',
        body: {
          'registry': registry == '' ? '2017010937' : registry,
          'password': password == '' ? '0123' : password,
        },
        handleException: (response) {
          throw ExceptionUserLogin();
        },
      );

      GetIt.I.get<UserModel>().update(UserModel.fromMap(response));

      return true;
    } catch (e) {
      return MessageUser.exceptionSnackBar(e);
    }
  }
}
