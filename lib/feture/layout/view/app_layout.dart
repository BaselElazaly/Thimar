import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/feture/layout/cubit/layout_cubit.dart';
import 'package:thimar/feture/layout/cubit/layout_state.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (cubit.currentIndex != 0) {
                cubit.changeNavBarIndex(0); 
              } else {
                SystemNavigator.pop(); 
              }
            },
            child: Scaffold(
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: Container(
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: BottomNavigationBar(
                  items: cubit.getBottomItems(context),
                  currentIndex: cubit.currentIndex,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: const Color(0xFFFFFFFF),
                  unselectedItemColor: const Color(0xFFAED489),
                  selectedLabelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    cubit.changeNavBarIndex(index);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}