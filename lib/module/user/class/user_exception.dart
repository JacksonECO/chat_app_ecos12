import 'package:ecos12_chat_app/app/exception_app.dart';

class ExceptionUserLogin extends ExceptionApp {}

class ExceptionUserLoginInvalid extends ExceptionApp {
  ExceptionUserLoginInvalid([String message = 'Matrícula inválida ou senha incorreta!']) : super(message);
}

class ExceptionUserRegister extends ExceptionApp {}

class ExceptionUserRegisterAlreadyExists extends ExceptionApp {
  ExceptionUserRegisterAlreadyExists([String message = 'Matrícula já cadastrada!']) : super(message);
}
