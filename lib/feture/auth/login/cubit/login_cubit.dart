import 'package:dio/dio.dart';
import 'package:thimar/core/cache/cache_helper.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/feture/auth/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:thimar/model/user_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({required String phone, required String password}) async {
    emit(LoginLoading());

    String? deviceToken = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> body = {
      "phone": "966$phone",
      "password": password,
      "device_token": deviceToken ?? "test_token",
      "type": Platform.isAndroid ? "android" : "ios",
      "user_type": "client",
    };

    final response = await getIt<ServerGate>().sendRequest(
      path: "login",
      data: body,
    );

    if (response.isSuccess) {
      UserModel user = UserModel.fromJson(response.data['data']);
      CacheHelper.saveToken(user.token ?? "");
      emit(LoginSuccess(message: response.message, userModel: user));
    } else {
      emit(LoginFailed(message: response.message));
    }
  }
}