import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thimar/core/services/location_service.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/feture/address/cubit/address_states.dart';

class AddAddressCubit extends Cubit<AddressStates> {
  final ServerGate _serverGate;

  AddAddressCubit(this._serverGate) : super(AddressInitialState());

  int selectedType = 0;
  GoogleMapController? mapController;
  double? currentLat, currentLng;
  bool isLoadingLocation = true;
  String currentAddressText = "جاري جلب العنوان...";

  Future<void> getUserLocation() async {
    isLoadingLocation = true;
    emit(GetLocationLoadingState());

    try {
      final locationData = await getIt<LocationService>().getCurrentLocation();
      currentLat = locationData.latitude;
      currentLng = locationData.longitude;

      isLoadingLocation = false;
      emit(GetLocationSuccessState());

      if (mapController != null && currentLat != null) {
        mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(currentLat!, currentLng!), 15),
        );
      }
    } catch (e) {
      isLoadingLocation = false;
      emit(GetLocationErrorState("failedGetLocation".tr()));
    }
  }

  Future<void> addAddress({
    required double lat,
    required double lng,
    required String location,
    required String description,
    required String phone,
    required String type,
  }) async {
    emit(AddAddressLoadingState());

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

    if (response.isSuccess) {
      emit(AddAddressSuccessState(response.message));
    } else {
      emit(AddAddressErrorState(response.message));
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

    if (response.isSuccess) {
      emit(AddAddressSuccessState(response.message));
    } else {
      emit(AddAddressErrorState(response.message));
    }
  }
}