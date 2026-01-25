import '../../../core/App_Imports/app_imports.dart';
// عدّل المسار حسب مكان الملف عندك

class SettingsProvider with ChangeNotifier {
  // ==============================
  // Theme & Language
  // ==============================

  ThemeMode themeMode = ThemeMode.system;
  String languauge = "ar";

  bool get isDark => themeMode == ThemeMode.dark;
  bool get isLight => themeMode == ThemeMode.light;

  // تحميل الإعدادات من SharedPreferences عند بداية التطبيق
  Future<void> loadSettings() async {
    final settings = await AppSettings.load();

    themeMode = settings.themeMode;
    languauge = settings.language.languageCode;

    notifyListeners();
  }

  // تغيير الثيم مع الحفظ
  Future<void> changeTheme(ThemeMode selectedTheme) async {
    themeMode = selectedTheme;

    await SettingsService.setThemeMode(selectedTheme);

    notifyListeners();
  }

  // تغيير اللغة مع الحفظ
  Future<void> changeLanguage(String selectedLanguage) async {
    languauge = selectedLanguage;

    await SettingsService.setLanguage(Locale(selectedLanguage));

    notifyListeners();
  }

  // ==============================
  // User Data
  // ==============================

  String? userName;
  bool isLoading = false;

  Future<void> loadUserName() async {
    isLoading = true;
    notifyListeners();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final uid = user.uid;
      final doc = await FirebaseFirestore.instance
          .collection('Admin')
          .doc(uid)
          .get();

      if (doc.exists) {
        userName = doc.data()?['name'];
      }
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> updateUserName(String newName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;

    await FirebaseFirestore.instance.collection('Admin').doc(uid).update({
      'name': newName,
    });

    userName = newName;
    notifyListeners();
  }

  // ==============================
  // Logout (اختياري)
  // ==============================

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
