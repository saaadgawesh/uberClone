import 'package:uberCloneDriver/core/App_Imports/app_imports.dart';

/// Settings data model
class AppSettings {
  final Locale language;
  final ThemeMode themeMode;

  const AppSettings({required this.language, required this.themeMode});

  /// Create a copy with updated values
  AppSettings copyWith({Locale? language, ThemeMode? themeMode}) {
    return AppSettings(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// Load settings from storage
  static Future<AppSettings> load() async {
    final language = await SettingsService.getLanguage();
    final themeMode = await SettingsService.getThemeMode();

    return AppSettings(language: language, themeMode: themeMode);
  }

  /// Save settings to storage
  Future<void> save() async {
    await SettingsService.setLanguage(language);
    await SettingsService.setThemeMode(themeMode);
  }
}
