import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/components/message_user.dart';
import 'package:ecos12_chat_app/screen/user/class/user_exception.dart';
import 'package:get_it/get_it.dart';

abstract class Login {
  static Future<bool> signIn({required String registry, required String password}) async {
    try {
      final response = await Rest.post(
        rota: '/login',
        body: {
          'registry': registry == '' ? '0102030405' : registry,
          'password': password == '' ? '123' : password,
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
