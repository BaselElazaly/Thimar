import 'package:flutter/material.dart';
import 'package:thimar/feture/address/view/add_address_view.dart';
import 'package:thimar/feture/address/view/addresses_view.dart';
import 'package:thimar/feture/address/view/update_address_view.dart';
import 'package:thimar/feture/auth/login/view/login_view.dart';
import 'package:thimar/feture/favorite/view/favorite_view.dart';
import 'package:thimar/feture/home/view/home_view.dart';
import 'package:thimar/feture/layout/view/app_layout.dart';
import 'package:thimar/feture/notfications/view/notfications_view.dart';
import 'package:thimar/feture/orders/view/orders_view.dart';
import 'package:thimar/feture/splash/view/splash_view.dart';
import 'package:thimar/feture/user/view/user_view.dart';

class Routes {
  static const String splashView = '/';
  static const String loginView = '/login';
  static const String layoutView = '/layout';
  static const String homeView = '/home';
  static const String ordersView = '/orders';
  static const String notficationsView = '/notfications';
  static const String favoriteView = '/favorite';
  static const String userView = '/user';
  static const String addressesView = '/addresses';
  static const String addAddressesView = '/add_Address';
  static const String updateAddressesView = '/update_Address';
}

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashView:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.layoutView:
        return MaterialPageRoute(builder: (_) => const AppLayout());
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.favoriteView:
        return MaterialPageRoute(builder: (_) => const FavoriteView());
      case Routes.ordersView:
        return MaterialPageRoute(builder: (_) => const OrdersView());
      case Routes.notficationsView:
        return MaterialPageRoute(builder: (_) => const NotficationsView());
      case Routes.userView:
        return MaterialPageRoute(builder: (_) => const UserView());
      case Routes.addressesView:
        return MaterialPageRoute(builder: (_) => const AddressesView());
      case Routes.addAddressesView:
        return MaterialPageRoute(builder: (_) => const AddAddressView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))),
        );
    }
  }
}
