import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode thememode = ThemeMode.dark;
  bool get isdark => thememode == ThemeMode.dark;
  Color get backgroundtheme =>
      isdark ? AppColors.blackColor : AppColors.whiteColor;
  void changeTheme(ThemeMode selectedTheme) {
    thememode = selectedTheme;
    notifyListeners();
  }

  String language = "ar";
  void changelanguage(String lang) {
    language = lang;
    notifyListeners();
  }
}
