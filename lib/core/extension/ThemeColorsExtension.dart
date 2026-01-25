import '../../core/App_Imports/app_imports.dart';

extension ThemeColorsExtension on BuildContext {
  Color get bgColor {
    final settingProvider = Provider.of<SettingsProvider>(this);

    return settingProvider.isDark ? AppColors.blackColor : AppColors.blueColor;
  }
}
