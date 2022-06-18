import 'package:ecos12_chat_app/class/model/user_model.dart';
import 'package:ecos12_chat_app/class/rest.dart';
import 'package:ecos12_chat_app/module/user/class/login.dart';
import 'package:ecos12_chat_app/module/user/class/register.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:faker/faker.dart';

/// Cria caso não exita e realiza o login
void main() {
  GetIt.I.registerSingleton<UserModel>(UserModel.init());
  test('Init', () async {
    await Rest.get(timeout: const Duration(minutes: 1));
  });
  test('User: Caio', () async {
    final user = await _registerOrLogin(nome: 'Caio', registry: '2017010937');
    expect(user, true);
  });
  test('User: Jackson', () async {
    final user = await _registerOrLogin(nome: 'Jackson', registry: '2018010136');
    expect(user, true);
  });

  test('New User Random', () async {
    var user = false;

    user = await newUserRandom();
    expect(user, true);
    user = await newUserRandom();
    expect(user, true);
    user = await newUserRandom();
    expect(user, true);
    user = await newUserRandom();
    expect(user, true);
  });

  test('All User', () async {
    final l = await Rest.get(path: '/users');
    print('');
    for (var element in l) {
      print(element['nickname'] + ': ' + element['registry']);
    }
    print('');
    expect(true, true);
  });
}

Future<bool> _registerOrLogin({required String nome, required String registry, String password = '123'}) async {
  bool user = false;
  try {
    user = await Login.signIn(
      registry: registry,
      password: password,
    );
  } catch (_) {}
  if (user) return true;

  try {
    user = await Register.call(
      name: nome,
      registry: registry,
      password: password,
      passwordConfirm: password,
    );
  } catch (_) {}
  try {
    user = await Login.signIn(
      registry: registry,
      password: password,
    );
  } catch (_) {}
  return user;
}

Future<bool> newUserRandom({String password = '123'}) async {
  var faker = Faker();
  bool user = false;

  final nome = faker.person.firstName() + ' ' + faker.person.lastName();
  final registry = faker.randomGenerator.integer(99999, min: 10000).toString();

  // print('User: $nome');
  // print('Registry: $registry');

  try {
    user = await Register.call(
      name: nome,
      registry: registry,
      password: password,
      passwordConfirm: password,
    );
  } catch (_) {}
  try {
    user = await Login.signIn(
      registry: registry,
      password: password,
    );
  } catch (_) {}
  return user;
}
