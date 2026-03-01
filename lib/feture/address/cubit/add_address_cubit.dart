import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/feture/address/cubit/address_states.dart';

class AddAddressCubit extends Cubit<AddressStates> {
  final ServerGate _serverGate;

  AddAddressCubit(this._serverGate) : super(AddressInitialState());

  Future<void> addAddress({
    required double lat,
    required double lng,
    required String location,
    required String description,
    required String phone,
    required String type,
  }) async {
    emit(AddAddressLoadingState());

    try {
      final response = await _serverGate.sendRequest(
        path: "client/addresses",
        data: {
          "lat": lat.toString(),
          "lng": lng.toString(),
          "location": location,
          "description": description,
          "phone": phone,
          "type": type.toLowerCase(),
          "is_default": 1,
        },
      );

      if (response.data['status'] == 'success') {
        emit(AddAddressSuccessState(
            response.data['message'] ?? "تمت الإضافة بنجاح"));
      } else {
        emit(AddAddressErrorState(response.data['message'] ?? "فشلت العملية"));
      }
    } catch (e) {
      if (e is DioException) {
        print("Server Message: ${e.response?.data}");
      }
      emit(AddAddressErrorState("حدث خطأ في البيانات المرسلة"));
    }
  }

  Future<void> updateAddress({
    required int id,
    required double lat,
    required double lng,
    required String location,
    required String description,
    required String phone,
    required String type,
  }) async {
    emit(AddAddressLoadingState());
    try {
      final response = await _serverGate.put(
        path: "client/addresses/$id",
        data: {
          "lat": lat.toString(),
          "lng": lng.toString(),
          "location": location,
          "description": description,
          "phone": phone,
          "type": type.toLowerCase(),
        },
      );

      if (response.data['status'] == 'success') {
        emit(AddAddressSuccessState(
            response.data['message'] ?? "تم التعديل بنجاح"));
      } else {
        emit(AddAddressErrorState(response.data['message'] ?? "فشلت العملية"));
      }
    } catch (e) {
      emit(AddAddressErrorState("حدث خطأ في الاتصال بالسيرفر"));
    }
  }
}
