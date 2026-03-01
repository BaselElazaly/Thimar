// ignore_for_file: unused_field

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/services/local_cubit.dart';
import 'package:thimar/core/services/location_service.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/address/cubit/add_address_cubit.dart';
import 'package:thimar/feture/address/cubit/address_states.dart';
import 'package:thimar/feture/address/widget/address_type_item.dart';
import 'package:thimar/feture/address/widget/custom_address_textfield.dart';
import 'package:thimar/feture/auth/widgets/default_button_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  int selectedType = 0;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GoogleMapController? _mapController;
  final Completer<GoogleMapController> _controllerCompleter = Completer();
  double? currentLat, currentLng;
  bool isLoadingLocation = true;
  String currentAddressText = "جاري جلب العنوان...";

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      final locationData = await getIt<LocationService>().getCurrentLocation();
      if (!mounted) return;

      setState(() {
        currentLat = locationData.latitude;
        currentLng = locationData.longitude;
        isLoadingLocation = false;
      });

      if (_mapController != null && currentLat != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(LatLng(currentLat!, currentLng!), 15),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoadingLocation = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddAddressCubit>(),
      child: BlocListener<AddAddressCubit, AddressStates>(
        listener: (context, state) {
          if (state is AddAddressSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is AddAddressErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: Text(
              context.l10n.addAddress,
              style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            leading: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Center(
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: BlocBuilder<LocaleCubit, Locale>(
                      builder: (context, locale) {
                        return Transform.rotate(
                          angle: locale.languageCode == 'ar' ? 0 : math.pi,
                          child: SvgPicture.asset(
                            'assets/icons/back_arrow.svg',
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    if (!isLoadingLocation && currentLat != null)
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              currentLat ?? 30.0444, currentLng ?? 31.2357),
                          zoom: 15,
                        ),
                        onMapCreated: (controller) {
                          _mapController = controller;
                          if (currentLat != null) {
                            _mapController!.animateCamera(
                              CameraUpdate.newLatLngZoom(
                                  LatLng(currentLat!, currentLng!), 15),
                            );
                          }
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        onCameraMove: (position) {
                          currentLat = position.target.latitude;
                          currentLng = position.target.longitude;
                        },
                        onCameraIdle: () async {
                          final address = await getIt<LocationService>()
                              .getAddressFromLatLng(currentLat!, currentLng!);
                          setState(() {
                            currentAddressText = address;
                          });
                        },
                      )
                    else
                      const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primary,
                      )),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 35),
                        child: Icon(Icons.location_on,
                            size: 45, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 6),
                                blurRadius: 17,
                                color: Colors.black.withOpacity(0.05))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '  ${context.l10n.addressType}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF8B8B8B),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(width: 10),
                          AddressTypeItem(
                            title: context.l10n.homeLocation,
                            isSelected: selectedType == 0,
                            onTap: () => setState(() => selectedType = 0),
                          ),
                          const SizedBox(width: 15),
                          AddressTypeItem(
                            title: context.l10n.workLocation,
                            isSelected: selectedType == 1,
                            onTap: () => setState(() => selectedType = 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomAddressTextField(
                      hintText: context.l10n.addPhoneNumber,
                      textInputType: TextInputType.phone,
                      controller: phoneNumberController,
                    ),
                    const SizedBox(height: 15),
                    CustomAddressTextField(
                      hintText: context.l10n.description,
                      textInputType: TextInputType.multiline,
                      controller: descriptionController,
                      maxLine: 3,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<AddAddressCubit, AddressStates>(
                      builder: (context, state) {
                        return DefaultButton(
                          text: state is AddAddressLoadingState
                              ? context.l10n.addingProgress
                              : context.l10n.addAddress,
                          onPress: state is AddAddressLoadingState
                              ? null
                              : () {
                                  context.read<AddAddressCubit>().addAddress(
                                        lat: currentLat!,
                                        lng: currentLng!,
                                        location: currentAddressText,
                                        description: descriptionController.text,
                                        phone: phoneNumberController.text,
                                        type:
                                            selectedType == 0 ? "Home" : "Work",
                                      );
                                },
                          btnColor: AppColors.primary,
                          btnShadowColor: Color(0xFF61B80C).withOpacity(0.19),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
