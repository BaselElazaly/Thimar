import 'package:thimar/model/user_model.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final String message;
  final UserModel userModel;
  LoginSuccess({required this.message, required this.userModel});
}

class LoginFailed extends LoginStates {
  final String message;
  LoginFailed({required this.message});
}