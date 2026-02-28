// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/cache/cache_helper.dart';
import 'package:thimar/core/route/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    startDelay();
  }

  void startDelay() {
    Timer(const Duration(seconds: 3), () {
      if (CacheHelper.getToken().isNotEmpty) {
        Navigator.pushReplacementNamed(context, Routes.layoutView); 
      } else {
        Navigator.pushReplacementNamed(context, Routes.loginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_bg.png',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.04),
              colorBlendMode: BlendMode.darken, 
            ),
          ),
          Center(
            child: SvgPicture.asset('assets/icons/logo.svg',
                width: (screenWidth * 0.5).clamp(180.0, 280.0)),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Transform.translate(
                offset: Offset(screenWidth * 0.3, screenHeight * 0.07),
                child: Image.asset(
                  'assets/images/bottom_fruits.png',
                  width: (screenWidth * 1.1).clamp(300.0, 500.0),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
