import '../App_Imports/app_imports.dart';

extension ThemeColorsExtension on BuildContext {
  Color get bgColor {
    final settingProvider = Provider.of<Settingprovider>(this, listen: false);

    return settingProvider.isDark
        ? AppColors.blackColor
        : AppColors.blueColor;
  }
}
