import 'package:uberCloneDriver/core/App_Imports/app_imports.dart';

class Settingprovider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;
  bool get islight => themeMode == ThemeMode.light;
  void changetheme(ThemeMode selectedtheme) {
    themeMode = selectedtheme;
    notifyListeners();
  }

  String languauge = "ar";
  void chanelanguage(String selectedLanguage) {
    languauge = selectedLanguage;
    notifyListeners();
  }
}
