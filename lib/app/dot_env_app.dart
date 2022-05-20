import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class DotEnvApp {
  static Future<void> init() async {
    await dotenv.load();
  }

  static String _get(String _var) {
    if (!dotenv.isInitialized) {
      throw 'DotEnv do not started';
    }
    try {
      return dotenv.maybeGet(_var)!;
    } catch (e) {
      throw 'Variable not exists';
    }
  }

  static  String get urlBase => _get('urlBase');
}
