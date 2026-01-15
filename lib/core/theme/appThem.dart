import '../Imports/app_imports.dart';

class Appthem {
  static ThemeData lighttheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.transparent,
      elevation: 0,
    ),
  );
  static ThemeData darktheme = ThemeData(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(elevation: 0),
  );
}
