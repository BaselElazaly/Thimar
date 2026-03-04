import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thimar/core/gen/assets.gen.dart';
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


  final List<Widget> screens = [
    const HomeView(),
    const OrdersView(),
    const NotficationsView(),
    const FavoriteView(),
    const UserView(),
  ];

  final List<String> selectedIcons = [
    Assets.icons.activeHomeNavbar,
    Assets.icons.activeOrdersNavbar,
    Assets.icons.activeNotficationNavbar,
    Assets.icons.activeFavoriteNavbar,
    Assets.icons.activeUserNavbar,
  ];

  final List<String> unselectedIcons = [
    Assets.icons.homeNavbar,
    Assets.icons.ordersNavbar,
    Assets.icons.notficationNavbar,
    Assets.icons.favoriteNavbar,
    Assets.icons.userNavbar,
  ];

  void changeNavBarIndex(int index) {
    currentIndex = index;
    emit(AppBottomNavState());
  }

  List<BottomNavigationBarItem> getBottomItems(BuildContext context) {
    final List<String> labels = [
      "home".tr(),
      "myOrders".tr(),
      "notifications".tr(),
      "favorites".tr(),
      "myAccount".tr(),
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
