import '../../../core/App_Imports/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  // if (kDebugMode) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // }

  await NotificationService().init();
  NotificationService().setUserRole(UserRole.rider);
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => SettingsProvider(),
      child: App(),
    ),
  );
}
