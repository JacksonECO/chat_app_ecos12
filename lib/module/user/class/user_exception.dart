
import 'package:ecos12_chat_app/app/exception_app.dart';

class ExceptionUserLogin extends ExceptionApp {}

class ExceptionUserRegister extends ExceptionApp {}

class ExceptionUserRegisterAlreadyExists extends ExceptionApp {
  ExceptionUserRegisterAlreadyExists([String message = 'Matrícula já cadastrada!']) : super(message);
}
