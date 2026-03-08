// ignore_for_file: empty_catches

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thimar/core/route/routes.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/feture/home/cubit/home_cubit.dart';
import 'package:thimar/feture/layout/cubit/layout_cubit.dart';
import 'package:thimar/feture/user/cubit/user_cubit.dart';
import 'package:thimar/feture/user/cubit/user_state.dart';
import 'package:thimar/feture/user/view/user_view.dart';
import 'package:thimar/feture/user/widget/profile_header_shimmer.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<ProfileCubit>()..getProfileData();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.28,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PositionedDirectional(
            end: -screenWidth * 0.24,
            child: CircleAvatar(
              radius: screenWidth * 0.2,
              backgroundColor: Colors.white.withOpacity(0.09),
            ),
          ),
          PositionedDirectional(
            start: -screenWidth * 0.1,
            top: screenHeight * 0.02,
            child: CircleAvatar(
              radius: screenWidth * 0.22,
              backgroundColor: Colors.white.withOpacity(0.03),
            ),
          ),
          PositionedDirectional(
            end: -screenWidth * 0.08,
            bottom: -screenHeight * 0.06,
            child: CircleAvatar(
              radius: screenWidth * 0.22,
              backgroundColor: Colors.white.withOpacity(0.09),
            ),
          ),
          PositionedDirectional(
            start: -screenWidth * 0.18,
            bottom: -screenHeight * 0.1,
            child: CircleAvatar(
              radius: screenWidth * 0.22,
              backgroundColor: Colors.white.withOpacity(0.09),
            ),
          ),
          PositionedDirectional(
            top: 45,
            start: 20,
            child: InkWell(
              onTap: () async {
                await context.setLocale(
                  context.locale.languageCode == 'ar'
                      ? const Locale('en')
                      : const Locale('ar'),
                );
                if (!context.mounted) return;
                final homeCubit = getIt<HomeCubit>();
                homeCubit.searchProducts = [];
                homeCubit.getProducts();

                getIt<ProfileCubit>().getProfileData();
                LayoutCubit.currentIndex = 4;
                Navigator.pushReplacementNamed(context, Routes.layoutView);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                ),
                child: Text(
                  context.locale.languageCode == 'ar' ? 'English' : 'عربي',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  "profileTitle".tr(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<ProfileCubit, ProfileStates>(
                  bloc: cubit,
                  builder: (context, state) {
                    final user = cubit.userModel;
                    if (state is GetProfileLoadingState) {
                      return const ProfileHeaderShimmer();
                    }

                    if (user != null) {
                      return Center(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                user.image,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;

                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.person,
                                        size: 70, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              user.fullname,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Directionality(
                              textDirection: ui.TextDirection.ltr,
                              child: Text(
                                '+${user.phone}',
                                style: const TextStyle(
                                  color: Color(0xFFA2D273),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
