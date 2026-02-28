
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:thimar/core/route/routes.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';

class AddAddressButton extends StatelessWidget {
  const AddAddressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.addAddressesView);
        },
        child: DottedBorder(
          color: AppColors.primary,
          strokeWidth: 1,
          dashPattern: const [4, 4],
          borderType: BorderType.RRect,
          radius: const Radius.circular(15),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                context.l10n.addAddress,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}