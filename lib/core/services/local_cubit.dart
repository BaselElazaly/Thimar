import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/cache/cache_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(_getInitialLocale());

  static Locale _getInitialLocale() {
    String savedLang = CacheHelper.getData(key: 'lang');
    
    if (savedLang.isEmpty || (savedLang != 'ar' && savedLang != 'en')) {
      return const Locale('ar');
    }
    
    return Locale(savedLang);
  }

  void changeLanguage(String langCode) {
    CacheHelper.saveData(key: 'lang', value: langCode);
    emit(Locale(langCode));
  }

  void toggleLanguage() {
    emit(state.languageCode == 'ar' ? const Locale('en') : const Locale('ar'));
    CacheHelper.saveData(key: 'lang', value: state.languageCode);
  }
}
