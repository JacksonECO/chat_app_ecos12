import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class Rest {
  static const String urlBase = '164.92.104.69';
  static const Map<String, String> headerBase = {'Content-Type': 'application/json'};
  static const Duration timeoutBase = Duration(seconds: 5);

  static Future<Map<String, dynamic>> get({
    String url = urlBase,
    String rota = '',
    Map<String, String> headers = const {},
    Duration timeout = timeoutBase,
  }) async {
    var response = await http.get(
      Uri.http(url, rota),
      headers: {...headerBase, ...headers},
    ).timeout(timeout);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw response.statusCode;
  }

  static Future<Map<String, dynamic>> post({
    String url = urlBase,
    String rota = '',
    Map<String, String> headers = const {},
    Map body = const {},
    Duration timeout = timeoutBase,
  }) async {
    var response = await http.post(
      Uri.http(url, rota),
      body: json.encode(body),
      headers: {...headerBase, ...headers},
    ).timeout(timeout);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw response.statusCode;
  }
}
