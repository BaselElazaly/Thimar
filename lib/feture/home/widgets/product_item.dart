import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thimar/core/utils/app_colors.dart';

class ProductItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String discount;
  final String unit;
  final String priceBeforeDiscount;
  final String priceAfterDiscount;

  const ProductItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.discount,
    required this.unit,
    required this.priceBeforeDiscount,
    required this.priceAfterDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.42,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(11),
            child: Stack(
              alignment: AlignmentGeometry.topLeft,
              children: [
                Container(
                  height: screenHeight * 0.14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey.withOpacity(0.4),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: -8,
                  left: -8,
                  child: Container(
                    height: screenHeight * 0.035,
                    width: screenWidth * 0.15,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  child: Text(
                    ' $discount%- ',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '${"price".tr()}/$unit',
                style: const TextStyle(
                  color: Color(0xFF808080),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.18),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$priceAfterDiscount ر.س',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                constraints: BoxConstraints(maxWidth: screenWidth * 0.14),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '$priceBeforeDiscount ر.س',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: AppColors.primary,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.primary,
                      decorationThickness: 20,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: screenWidth * 0.08,
                height: screenWidth * 0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.secondry,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.secondry,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "addToCart".tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
