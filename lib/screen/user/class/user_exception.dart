import 'package:ecos12_chat_app/app/app_exception.dart';

class ExceptionUserLogin extends AppException {}

class ExceptionUserRegister extends AppException {}

class ExceptionUserRegisterAlreadyExists extends AppException {
  ExceptionUserRegisterAlreadyExists([String message = 'Matrícula já cadastrada!']) : super(message);
}
