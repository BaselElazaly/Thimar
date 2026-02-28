import 'package:flutter/material.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'category_box.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> boxText = [
      context.l10n.vegetables,
      context.l10n.fruits,
      context.l10n.meat,
      context.l10n.spices,
      context.l10n.dates,
      context.l10n.nuts,
    ];
    final List<String> svgPath = const [
      'assets/icons/vegetable.svg',
      'assets/icons/fruit.svg',
      'assets/icons/steak.svg',
      'assets/icons/spices.svg',
      'assets/icons/dates.svg',
      'assets/icons/almond.svg'
    ];
    final List<Color> boxColor1 = const [
      Color(0xFFF6F9F3),
      Color(0xFFFFFAEE),
      Color(0xFFFFF8F6),
      Color(0xFFF6FCFE),
      Color(0xFFFDF7F5),
      Color(0xFFF4F5F6)
    ];
    final List<Color> boxColor2 = const [
      Color(0xFFEBF5E1),
      Color(0xFFFFF1CE),
      Color(0xFFFCDFD7),
      Color(0xFFE9FAFF),
      Color(0xFFFFE7DF),
      Color(0xFFEBF2F9)
    ];

    return Column(
      children: [
        Row(
          children: [
            Text(
              context.l10n.categories,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
            const Spacer(),
            Text(
              context.l10n.viewAll,
              style: const TextStyle(color: AppColors.primary, fontSize: 15),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            scrollDirection: Axis.horizontal,
            itemCount: boxText.length,
            itemBuilder: (context, index) => CategoryBox(
              boxText: boxText[index],
              svgPath: svgPath[index],
              boxColor1: boxColor1[index],
              boxColor2: boxColor2[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 16),
          ),
        ),
      ],
    );
  }
}