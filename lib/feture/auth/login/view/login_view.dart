import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/gen/assets.gen.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/feture/auth/login/cubit/login_cubit.dart';
import 'package:thimar/feture/auth/login/cubit/login_state.dart';
import 'package:thimar/feture/auth/widgets/country_code_widget.dart';
import 'package:thimar/feture/auth/widgets/custom_text_field_widget.dart';
import 'package:thimar/feture/auth/widgets/default_button_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final cubit = getIt<LoginCubit>();
    return BlocConsumer<LoginCubit, LoginStates>(
      bloc: cubit,
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, '/layout');
        } else if (state is LoginFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  Assets.images.splashBg.path,
                  fit: BoxFit.cover,
                  color: Colors.white.withAlpha(100),
                  colorBlendMode: BlendMode.lighten,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        SvgPicture.asset(
                          Assets.icons.logo,
                          width: screenWidth * 0.33,
                        ),
                        const SizedBox(
                          height: 21,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 9),
                          child: Text(
                            "welcomeBack".tr(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 14),
                          child: Text(
                            "loginNow".tr(),
                            style: const TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const CountryCodeWidget(),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  controller: phoneController,
                                  hintText: "phoneNumber".tr(),
                                  iconPath: Assets.icons.phone,
                                  textInputType: TextInputType.phone,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "password".tr(),
                          iconPath: Assets.icons.unlock,
                          textInputType: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Text(
                                "forgetPassword".tr(),
                                style: const TextStyle(
                                  color: Color(0xFF707070),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        state is LoginLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ))
                            : DefaultButton(
                                text: "login".tr(),
                                btnColor: AppColors.primary,
                                btnShadowColor: const Color(0xFF61B80C),
                                onPress: () {
                                  if (phoneController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty) {
                                    cubit.loginUser(
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(content: Text("enterFullData".tr())),
                                    );
                                  }
                                },
                              ),
                        const SizedBox(
                          height: 45,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Tajawal',
                                color: AppColors.primary,
                              ),
                              children: [
                                TextSpan(
                                  text: "dontHaveAccount".tr(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: "registerNow".tr(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
