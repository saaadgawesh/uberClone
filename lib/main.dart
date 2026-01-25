import 'core/Imports/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();

  // تحميل إعدادات SharedPreferences
  final settingsProvider = SettingsProvider();
  await settingsProvider.loadSettings();

  runApp(ChangeNotifierProvider.value(value: settingsProvider, child: App()));
}
