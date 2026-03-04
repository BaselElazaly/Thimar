import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart'; 
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/feture/user/cubit/user_state.dart';
import 'package:thimar/model/user_model.dart'; 

class ProfileCubit extends Cubit<ProfileStates> {
  final ServerGate serverGate; 
  
  ProfileCubit(this.serverGate) : super(ProfileInitialState());

  UserModel? userModel;

  Future<void> getProfileData() async {
    emit(GetProfileLoadingState());
  
    final response = await serverGate.get(path: 'client/profile');

    if (isClosed) return;

    if (response.isSuccess) {
      try {
        userModel = UserModel.fromJson(response.data['data']);
        emit(GetProfileSuccessState(userModel!));
      } catch (e) {
        print("Error in getProfileData: $e");
        emit(GetProfileErrorState("default_error".tr()));
      }
    } else {
      emit(GetProfileErrorState(response.message));
    }
  }
}