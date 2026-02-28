import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/feture/user/cubit/user_cubit.dart';
import 'package:thimar/feture/user/widget/profile_body_section.dart';
import 'package:thimar/feture/user/widget/profile_header_section.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfileData(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFFF9F9F9), 
          body: Column( 
            children: const [
              ProfileHeader(),
              Expanded( 
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: ProfileBodySection(), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}