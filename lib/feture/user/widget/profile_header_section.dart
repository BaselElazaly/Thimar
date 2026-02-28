// ignore_for_file: empty_catches

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/local_cubit.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/home/cubit/home_cubit.dart';
import 'package:thimar/feture/user/cubit/user_cubit.dart';
import 'package:thimar/feture/user/cubit/user_state.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: BlocBuilder<LocaleCubit, Locale>(
              builder: (context, locale) {
                return InkWell(
                  onTap: () {
                    context.read<LocaleCubit>().toggleLanguage();
                    try {
                      context.read<HomeCubit>().getSliders();
                      context.read<HomeCubit>().getProducts();
                    } catch (e) {}
                    context.read<ProfileCubit>().getProfileData();
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
                      locale.languageCode == 'ar' ? 'English' : 'عربي',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          BlocBuilder<ProfileCubit, ProfileStates>(
            builder: (context, state) {
              final user = context.read<ProfileCubit>().userModel;

              if (state is GetProfileLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              if (user != null) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        context.l10n.profileTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          user.image,
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
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
                        textDirection: TextDirection.ltr,
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
    );
  }
}
