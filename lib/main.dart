import '../../../core/App_Imports/app_imports.dart';
import 'package:flutter/services.dart';
import 'package:uberCloneRider/core/di/service_Locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeHive();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  serviceLocatorConfiguration(); // Initialize service locator
  Bloc.observer = AppBlocObserver();
  // if (kDebugMode) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // }

  final settingProvider = SettingsProvider();
  await settingProvider.loadSettings();
  runApp(ChangeNotifierProvider.value(value: settingProvider, child: App()));
}

Future<void> _initializeHive() async {
  try {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(TripsModelAdapter().typeId)) {
      Hive.registerAdapter(TripsModelAdapter());
    }

    if (!Hive.isBoxOpen('tripsBox')) {
      await Hive.openBox<TripsModel>('tripsBox');
    }
  } on MissingPluginException catch (error, stackTrace) {
    debugPrint('Hive startup skipped because path_provider is unavailable: $error');
    debugPrintStack(stackTrace: stackTrace);
  }
}
