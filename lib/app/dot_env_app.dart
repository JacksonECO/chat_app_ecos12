abstract class DotEnvApp {
  static const String _null = 'null';

  static void init() {
    for (var element in [
      urlBase,
    ]) {
      if (element == _null) {
        throw 'DotEnvApp: Variable not exists';
      }
    }
  }

  static const String urlBase = String.fromEnvironment('urlBase', defaultValue: _null);
}
