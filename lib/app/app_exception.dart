abstract class AppException implements Exception {
  static const String messageDefault = 'Tente novamente mais tarde!';
  final String message;
  AppException([this.message = messageDefault]);

  @override
  String toString() => '$runtimeType(message: $message)';

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other.runtimeType == runtimeType;
  }
}


