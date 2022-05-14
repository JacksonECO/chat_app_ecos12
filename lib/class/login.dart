import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:get_it/get_it.dart';

abstract class Login {
  static Uri uri = Uri.http('164.92.104.69', '/login');
  static signIn({required String registry, required String password}) async {
    try {
      var response = await Rest.post(rota: '/login', body: {
        'registry': registry == '' ? '0123456789' : registry,
        'password': password == '' ? '123' : password,
      });

      GetIt.I.get<UserModel>().update(UserModel.fromMap(response));

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
