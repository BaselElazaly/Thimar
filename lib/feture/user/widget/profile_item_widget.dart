import 'dart:math' as math; // محتاجين دي عشان نلف السهم
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/utils/app_colors.dart';

class ProfileItem extends StatelessWidget {
  final String title, iconPath;
  final VoidCallback onTap;
  final bool isLogout;

  const ProfileItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Row(
          children: [
            if (!isLogout) ...[
              SvgPicture.asset(
                iconPath,
                width: 20,
                colorFilter:
                    const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
              const SizedBox(width: 15),
            ],

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const Spacer(),

            if (!isLogout)
              Transform.rotate(
                angle: isArabic ? 0 : math.pi,
                child: SvgPicture.asset(
                  'assets/icons/profile_arrow.svg',
                  width: 20,
                ),
              )
            else
              SvgPicture.asset(
                'assets/icons/logout.svg',
                width: 24,
              ),
          ],
        ),
      ),
    );
  }
}