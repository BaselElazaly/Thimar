// ignore_for_file: unused_field

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

class UpdateAddressView extends StatefulWidget {
  final dynamic addressModel;
  const UpdateAddressView({super.key, required this.addressModel});

  @override
  State<UpdateAddressView> createState() => _UpdateAddressViewState();
}

class _UpdateAddressViewState extends State<UpdateAddressView> {
  late int selectedType;
  late TextEditingController phoneNumberController;
  late TextEditingController descriptionController;

  double? currentLat, currentLng;
  String? currentAddressText;
  bool isLoadingLocation = false;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    phoneNumberController =
        TextEditingController(text: widget.addressModel.phone);
    descriptionController =
        TextEditingController(text: widget.addressModel.description);
    currentLat = double.parse(widget.addressModel.lat.toString());
    currentLng = double.parse(widget.addressModel.lng.toString());
    currentAddressText = widget.addressModel.location;
    selectedType = widget.addressModel.type == "home" ? 0 : 1;
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
              context.l10n.updateAddress,
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
                    if (!isLoadingLocation)
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(currentLat!, currentLng!),
                          zoom: 15,
                        ),
                        onMapCreated: (controller) =>
                            _mapController = controller,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
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
                              ? context.l10n.updatingProgress
                              : context.l10n.updateAddress,
                          onPress: state is AddAddressLoadingState
                              ? null
                              : () {
                                  context.read<AddAddressCubit>().updateAddress(
                                        id: widget.addressModel.id,
                                        lat: currentLat!,
                                        lng: currentLng!,
                                        location: currentAddressText!,
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
