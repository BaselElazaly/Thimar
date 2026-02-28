import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/feture/address/cubit/address_states.dart';
import 'package:thimar/model/adderss_model.dart';

class AddressCubit extends Cubit<AddressStates> {
  final ServerGate _serverGate;
  AddressCubit(this._serverGate) : super(AddressInitialState());

  List<AddressModel> addresses = [];

  Future<void> getAddresses({bool isRefresh = false}) async {
    if (!isRefresh) emit(GetAddressesLoadingState());
    final response = await _serverGate.get(path: "client/addresses");
    if (response.isSuccess) {
      try {
        addresses = AddressData.fromJson(response.data).list;
        emit(GetAddressesSuccessState());
      } catch (e) {
        emit(GetAddressesErrorState("حدث خطأ أثناء معالجة البيانات"));
      }
    } else {
      emit(GetAddressesErrorState(response.message));
    }
  }

  Future<void> deleteAddress(int id) async {
    // 1. إظهار حالة التحميل (عشان اليوزر ميعملش أكشن تاني)
    emit(DeleteAddressLoadingState());

    // 2. إرسال طلب المسح للسيرفر
    // بنستخدم ميثود delete اللي في الـ ServerGate وبنبعت الـ ID في الـ path
    final response = await _serverGate.delete(path: "client/addresses/$id");

    if (response.isSuccess) {
      // 3. مسح العنوان من القائمة اللي في الميموري فوراً عشان الـ UI يتحدث
      addresses.removeWhere((element) => element.id == id);
      emit(DeleteAddressSuccessState(response.message));
    } else {
      // 4. إظهار رسالة الخطأ لو المسح فشل
      emit(DeleteAddressErrorState(response.message));
    }
  }
}
