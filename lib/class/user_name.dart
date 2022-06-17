import 'package:ecos12_chat_app/class/rest.dart';

abstract class UserName {
  static final Map<String, String> _database = {};

  static Future<String> byRegistry(String registry) async {
    if (_database[registry] == null) {
      return _request(registry);
    }
    return _database[registry]!;
  }

  static Future<String> _request(String registry) async {
    final user = await Rest.get(
      path: '/users/$registry',
    );

    _database.addAll({
      user['registry']: user['nickname'],
    });

    return user['nickname'];
  }
}
