// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/auth/widgets/custom_text_field_widget.dart';

class HomeHeaderSection extends StatelessWidget {
  final TextEditingController searchController;

  const HomeHeaderSection({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              // 1. الجزء بتاع اللوجو (أديناه عرض ثابت أو خليناه Expanded عشان التوازن)
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/logo.svg', width: 20),
                    const SizedBox(width: 4),
                    Text(
                      'سلة ثمار',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. الجزء بتاع العنوان (دلوقتي هو في نص الشاشة بالضبط)
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.l10n.deliveryTo,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                    const Text(
                      'شارع الملك فهد - جدة',
                      textAlign: TextAlign.center, // عشان النص يتركز
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // 3. الجزء بتاع السلة
              Expanded(
                flex: 2,
                child: Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: AppColors.primary.withOpacity(0.13),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/cart.svg',
                          width: 20,
                        ),
                      ),
                      PositionedDirectional(
                        top: -4,
                        end: -4,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1, color: Colors.white),
                          ),
                          child: const Center(
                            child: Text(
                              '3',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            hintText: context.l10n.searchHint,
            iconPath: 'assets/icons/search.svg',
            textInputType: TextInputType.text,
            controller: searchController,
            fillColor: AppColors.primary.withOpacity(0.03),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
