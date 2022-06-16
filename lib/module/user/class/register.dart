import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/module/user/class/login.dart';
import 'package:ecos12_chat_app/module/user/class/user_exception.dart';
import 'package:ecos12_chat_app/widgets/message_user.dart';
import 'package:ecos12_chat_app/widgets/message_user_status.dart';

abstract class Register {
  static Future<bool> call({
    required String name,
    required String registry,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      final valid = _validate(name: name, registry: registry, password: password, passwordConfirm: passwordConfirm);
      if (valid != null) {
        MessageUser.showSnackBar(valid, status: StatusMessageUser.error);
        return false;
      }

      final response = await Rest.post(
        path: '/users',
        body: {
          'nickname': name,
          'registry': registry,
          'password': password,
        },
        handleException: (response) {
          if (response.body.contains('already exists') && response.body.contains('registry ')) {
            throw ExceptionUserRegisterAlreadyExists();
          }
          throw ExceptionUserRegister();
        },
      );
      print(response);

      return Login.signIn(registry: registry, password: password);
    } catch (e) {
      return MessageUser.exceptionSnackBar(e);
    }
  }

  static String? _validate({
    required String name,
    required String registry,
    required String password,
    required String passwordConfirm,
  }) {
    if (name == '') {
      return 'Digite seu nome';
    }

    if (registry == '') {
      return 'Digite sua matrícula';
    }
    if (registry.length < 5 || registry.length > 10) {
      return 'Matrícula inválida!';
    }

    if (password == '') {
      return 'Digite sua senha';
    }
    if (password.length < 3) {
      return 'Senha insuficiente';
    }
    if (password != passwordConfirm) {
      return 'Senhas não conferem';
    }

    return null;
  }
}
