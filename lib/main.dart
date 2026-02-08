import '../../../core/App_Imports/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TripsModelAdapter());

  Hive.openBox<TripsModel>("tripsBox");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  // if (kDebugMode) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // }

  final settingProvider = SettingsProvider();
  await settingProvider.loadSettings();
  runApp(ChangeNotifierProvider.value(value: SettingsProvider(), child: App()));
}
