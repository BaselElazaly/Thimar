import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/favorite/view/favorite_view.dart';
import 'package:thimar/feture/home/view/home_view.dart';
import 'package:thimar/feture/layout/cubit/layout_state.dart';
import 'package:thimar/feture/notfications/view/notfications_view.dart';
import 'package:thimar/feture/orders/view/orders_view.dart';
import 'package:thimar/feture/user/view/user_view.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  static LayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  
  // شيلنا الـ labels من هنا لأن الـ context مش مكانه الـ Cubit

  final List<Widget> screens = [
    const HomeView(),
    const OrdersView(),
    const NotficationsView(),
    const FavoriteView(),
    const UserView(),
  ];

  final List<String> unselectedIcons = [
    'assets/icons/home_navbar.svg',
    'assets/icons/orders_navbar.svg',
    'assets/icons/notfication_navbar.svg',
    'assets/icons/favorite_navbar.svg',
    'assets/icons/user_navbar.svg',
  ];

  final List<String> selectedIcons = [
    'assets/icons/active_home_navbar.svg',
    'assets/icons/active_orders_navbar.svg',
    'assets/icons/active_notfication_navbar.svg',
    'assets/icons/active_favorite_navbar.svg',
    'assets/icons/active_user_navbar.svg',
  ];

  void changeNavBarIndex(int index) {
    currentIndex = index;
    emit(AppBottomNavState());
  }

  List<BottomNavigationBarItem> getBottomItems(BuildContext context) {
    final List<String> labels = [
      context.l10n.home,
      context.l10n.myOrders,
      context.l10n.notifications,
      context.l10n.favorites,
      context.l10n.myAccount,
    ];

    return List.generate(selectedIcons.length, (index) {
      final bool isSelected = currentIndex == index;

      return BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SvgPicture.asset(
            isSelected ? selectedIcons[index] : unselectedIcons[index],
            width: 24,
            height: 24,
          ),
        ),
        label: labels[index], 
      );
    });
  }
}