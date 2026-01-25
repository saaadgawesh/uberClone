import '../../core/Imports/app_imports.dart';

extension SettingProviderExtension on BuildContext {
  SettingsProvider get settingProvider {
    return Provider.of<SettingsProvider>(this, listen: false);
  }
}
