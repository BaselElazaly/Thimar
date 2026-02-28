// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  // skipped getter for the '// Login Screen Section' key

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `You can login now`
  String get loginNow {
    return Intl.message(
      'You can login now',
      name: 'loginNow',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Please enter full data`
  String get enterFullData {
    return Intl.message(
      'Please enter full data',
      name: 'enterFullData',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register Now`
  String get registerNow {
    return Intl.message(
      'Register Now',
      name: 'registerNow',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '// Home Screen Section' key

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Delivery to`
  String get deliveryTo {
    return Intl.message('Delivery to', name: 'deliveryTo', desc: '', args: []);
  }

  /// `Search for what you want?`
  String get searchHint {
    return Intl.message(
      'Search for what you want?',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message('Items', name: 'items', desc: '', args: []);
  }

  /// `Permanent Offers`
  String get permanentOffers {
    return Intl.message(
      'Permanent Offers',
      name: 'permanentOffers',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message('Add to Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  // skipped getter for the '// Categories Types Section' key

  /// `Vegetables`
  String get vegetables {
    return Intl.message('Vegetables', name: 'vegetables', desc: '', args: []);
  }

  /// `Fruits`
  String get fruits {
    return Intl.message('Fruits', name: 'fruits', desc: '', args: []);
  }

  /// `Meat`
  String get meat {
    return Intl.message('Meat', name: 'meat', desc: '', args: []);
  }

  /// `Spices`
  String get spices {
    return Intl.message('Spices', name: 'spices', desc: '', args: []);
  }

  /// `Dates`
  String get dates {
    return Intl.message('Dates', name: 'dates', desc: '', args: []);
  }

  /// `Nuts`
  String get nuts {
    return Intl.message('Nuts', name: 'nuts', desc: '', args: []);
  }

  // skipped getter for the '// Bottom Navigation Bar' key

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message('My Orders', name: 'myOrders', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `My Account`
  String get myAccount {
    return Intl.message('My Account', name: 'myAccount', desc: '', args: []);
  }

  // skipped getter for the '// Profile Screen - Titles' key

  /// `My Account`
  String get profileTitle {
    return Intl.message('My Account', name: 'profileTitle', desc: '', args: []);
  }

  // skipped getter for the '// Profile Screen - Data' key

  /// `Personal Data`
  String get personalData {
    return Intl.message(
      'Personal Data',
      name: 'personalData',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message('Wallet', name: 'wallet', desc: '', args: []);
  }

  /// `Addresses`
  String get addresses {
    return Intl.message('Addresses', name: 'addresses', desc: '', args: []);
  }

  /// `Payment`
  String get payment {
    return Intl.message('Payment', name: 'payment', desc: '', args: []);
  }

  // skipped getter for the '// Profile Screen - Support' key

  /// `FAQ`
  String get faq {
    return Intl.message('FAQ', name: 'faq', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Complaints & Suggestions`
  String get complaints {
    return Intl.message(
      'Complaints & Suggestions',
      name: 'complaints',
      desc: '',
      args: [],
    );
  }

  /// `Share App`
  String get shareApp {
    return Intl.message('Share App', name: 'shareApp', desc: '', args: []);
  }

  // skipped getter for the '// Profile Screen - Settings' key

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  // skipped getter for the '// Adressess Screen' key

  /// `Add Address`
  String get addAddress {
    return Intl.message('Add Address', name: 'addAddress', desc: '', args: []);
  }

  /// `Work`
  String get workLocation {
    return Intl.message('Work', name: 'workLocation', desc: '', args: []);
  }

  /// `Home`
  String get homeLocation {
    return Intl.message('Home', name: 'homeLocation', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `description`
  String get description {
    return Intl.message('description', name: 'description', desc: '', args: []);
  }

  /// `There are no addresses`
  String get noAddresses {
    return Intl.message(
      'There are no addresses',
      name: 'noAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Address Type`
  String get addressType {
    return Intl.message(
      'Address Type',
      name: 'addressType',
      desc: '',
      args: [],
    );
  }

  /// `add phoneNumber`
  String get addPhoneNumber {
    return Intl.message(
      'add phoneNumber',
      name: 'addPhoneNumber',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
