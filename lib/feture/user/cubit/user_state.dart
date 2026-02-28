
import 'package:thimar/model/user_model.dart';

abstract class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class GetProfileLoadingState extends ProfileStates {}

class GetProfileSuccessState extends ProfileStates {
  final UserModel userModel;
  GetProfileSuccessState(this.userModel);
}

class GetProfileErrorState extends ProfileStates {
  final String msg;
  GetProfileErrorState(this.msg);
}