import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/module/user/class/login.dart';
import 'package:ecos12_chat_app/module/user/class/register.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

/// Cria caso não exita e realiza o login
void main() {
  GetIt.I.registerSingleton<UserModel>(UserModel.init());
  test('User: Caio', () async {
    var user = false;
    try {
      user = await Register.call(
        name: 'Caio',
        registry: '2017010937',
        password: '123',
        passwordConfirm: '123',
      );
    } catch (_) {}
    try {
      user = await Login.signIn(
        registry: '2017010937',
        password: '123',
      );
    } catch (e) {}
    expect(user, true);
  });
  test('User: Jackson', () async {
    var user = false;
    try {
      user = await Register.call(
        name: 'Jackson',
        registry: '2018010136',
        password: '123',
        passwordConfirm: '123',
      );
    } catch (_) {}
    try {
      user = await Login.signIn(
        registry: '2018010136',
        password: '123',
      );
    } catch (e) {}
    expect(user, true);
  });
}
