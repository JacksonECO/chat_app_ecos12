import 'dart:convert';

import 'package:ecos12_chat_app/app/app_exception.dart';
import 'package:ecos12_chat_app/app/dot_env_app.dart';
import 'package:http/http.dart' as http;

class ExceptionRest extends AppException {}

abstract class Rest {
  static const Map<String, String> headerBase = {'Content-Type': 'application/json'};
  static const Duration timeoutBase = Duration(seconds: 5);

  static Future<Map<String, dynamic>> get({
    String? url,
    String rota = '',
    Map<String, String> headers = const {},
    Duration timeout = timeoutBase,
    void Function(http.Response response)? handleException,
  }) async {
    url ??= DotEnvApp.urlBase;

    var response = await http.get(
      Uri.https(url, rota),
      headers: {...headerBase, ...headers},
    ).timeout(timeout);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    if (handleException != null) {
      handleException(response);
    }
    print(response.statusCode);
    print(response.body);
    throw ExceptionRest();
  }

  static Future<Map<String, dynamic>> post({
    String? url,
    String rota = '',
    Map<String, String> headers = const {},
    Map body = const {},
    Duration timeout = timeoutBase,
    void Function(http.Response response)? handleException,
  }) async {
    url ??= DotEnvApp.urlBase;

    var response = await http.post(
      Uri.https(url, rota),
      body: json.encode(body),
      headers: {...headerBase, ...headers},
    ).timeout(timeout);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    if (handleException != null) {
      handleException(response);
    }
    print(response.statusCode);
    print(response.body);
    throw ExceptionRest();
  }
}
