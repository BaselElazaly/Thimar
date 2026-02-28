import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/services/local_cubit.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/address/widget/address_type_item.dart';
import 'package:thimar/feture/address/widget/custom_address_textfield.dart';
import 'package:thimar/feture/auth/widgets/custom_text_field_widget.dart';
import 'package:thimar/feture/auth/widgets/default_button_widget.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  int selectedType = 0;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Container(
                  width: double.infinity,
                  color: AppColors.primary.withOpacity(0.1),
                  child: const Center(
                    child:
                        Icon(Icons.map_outlined, size: 100, color: Colors.grey),
                  ),
                ),
                const Center(
                  child: Icon(Icons.location_on,
                      size: 45, color: AppColors.primary),
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
                          context.l10n.addressType,
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
                DefaultButton(
                  text: context.l10n.addAddress,
                  btnColor: AppColors.primary,
                  btnShadowColor: Color(0xFF61B80C).withOpacity(0.19),
                  onPress: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
