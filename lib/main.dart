import 'core/App_Imports/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  runApp(
    ChangeNotifierProvider(create: (_) => Settingprovider(), child: App()),
  );
}
