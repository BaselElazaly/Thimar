// ignore_for_file: unused_field

import 'dart:async';
import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thimar/core/gen/assets.gen.dart';
import 'package:thimar/core/services/location_service.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/feture/address/cubit/add_address_cubit.dart';
import 'package:thimar/feture/address/cubit/address_cubit.dart';
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
  final cubit = getIt<AddAddressCubit>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit.getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddAddressCubit, AddressStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state is AddAddressSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          getIt<AddressCubit>().getAddresses();
          Navigator.pop(context);
        } else if (state is AddAddressErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "addAddress".tr(),
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
                  child: Transform.rotate(
                    angle: context.locale.languageCode == 'ar' ? 0 : math.pi,
                    child: SvgPicture.asset(
                      Assets.icons.backArrow,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: BlocBuilder<AddAddressCubit, AddressStates>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (cubit.isLoadingLocation || cubit.currentLat == null) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      );
                    }
                    return Stack(
                      children: [
                        GoogleMap(
                          gestureRecognizers: <Factory<
                              OneSequenceGestureRecognizer>>{
                            Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                          },
                          initialCameraPosition: CameraPosition(
                            target:
                                LatLng(cubit.currentLat!, cubit.currentLng!),
                            zoom: 15,
                          ),
                          onMapCreated: (controller) {
                            cubit.mapController = controller;
                          },
                          myLocationEnabled: true,
                          myLocationButtonEnabled: true,
                          onCameraMove: (position) {
                            cubit.currentLat = position.target.latitude;
                            cubit.currentLng = position.target.longitude;
                          },
                          onCameraIdle: () async {
                            final address = await getIt<LocationService>()
                                .getAddressFromLatLng(
                                    cubit.currentLat!, cubit.currentLng!);
                            if (mounted) {
                              setState(() {
                                cubit.currentAddressText = address;
                              });
                            }
                          },
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 35),
                            child: Icon(Icons.location_on,
                                size: 45, color: AppColors.primary),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 6),
                                blurRadius: 17,
                                color: Colors.black.withOpacity(0.05))
                          ]),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '  ${"addressType".tr()}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF8B8B8B),
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          const SizedBox(width: 10),
                          AddressTypeItem(
                            title: "homeLocation".tr(),
                            isSelected: cubit.selectedType == 0,
                            onTap: () => setState(() => cubit.selectedType = 0),
                          ),
                          const SizedBox(width: 15),
                          AddressTypeItem(
                            title: "workLocation".tr(),
                            isSelected: cubit.selectedType == 1,
                            onTap: () => setState(() => cubit.selectedType = 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomAddressTextField(
                      hintText: "addPhoneNumber".tr(),
                      textInputType: TextInputType.phone,
                      controller: phoneNumberController,
                    ),
                    const SizedBox(height: 15),
                    CustomAddressTextField(
                      hintText: "description".tr(),
                      textInputType: TextInputType.multiline,
                      controller: descriptionController,
                      maxLine: 3,
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<AddAddressCubit, AddressStates>(
                      bloc: cubit,
                      builder: (context, state) {
                        return DefaultButton(
                          text: state is AddAddressLoadingState
                              ? "addingProgress".tr()
                              : "addAddress".tr(),
                          onPress: state is AddAddressLoadingState
                              ? null
                              : () {
                                  cubit.addAddress(
                                    lat: cubit.currentLat!,
                                    lng: cubit.currentLng!,
                                    location: cubit.currentAddressText,
                                    description: descriptionController.text,
                                    phone: phoneNumberController.text,
                                    type: cubit.selectedType == 0
                                        ? "Home"
                                        : "Work",
                                  );
                                },
                          btnColor: AppColors.primary,
                          btnShadowColor:
                              const Color(0xFF61B80C).withOpacity(0.19),
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
