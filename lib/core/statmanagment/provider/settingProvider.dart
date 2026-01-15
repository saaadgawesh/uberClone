import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

class Settingprovider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  bool get isDark => themeMode == ThemeMode.dark;
  void changetheme(ThemeMode selectedtheme) {
    themeMode = selectedtheme;
    notifyListeners();
  }

  String languauge = "en";
  void chanelanguage(String selectedLanguage) {
    languauge = selectedLanguage;
    notifyListeners();
  }
}
