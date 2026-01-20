import '../App_Imports/app_imports.dart';

extension SettingProviderExtension on BuildContext {
  Settingprovider get settingProvider {
    return Provider.of<Settingprovider>(this, listen: false);
  }
}
