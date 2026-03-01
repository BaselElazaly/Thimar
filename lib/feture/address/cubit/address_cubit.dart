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

    if (isClosed) return;

    if (response.isSuccess) {
      try {
        addresses = AddressData.fromJson(response.data).list;

        emit(GetAddressesSuccessState(response));
      } catch (e) {
        emit(GetAddressesErrorState("حدث خطأ أثناء معالجة البيانات"));
      }
    } else {
      emit(GetAddressesErrorState(response.message));
    }
  }

  Future<void> deleteAddress(int id) async {
    emit(DeleteAddressLoadingState());
    final response = await _serverGate.delete(path: "client/addresses/$id");

    if (response.isSuccess) {
      addresses.removeWhere((element) => element.id == id);
      emit(DeleteAddressSuccessState(response.message));
    } else {
      emit(DeleteAddressErrorState(response.message));
    }
  }
}
