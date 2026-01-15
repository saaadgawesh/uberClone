import 'package:flutter/foundation.dart';

import '../../../core/App_Imports/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  if (kDebugMode) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => Settingprovider(),
      child: App(),
    ),
  );
}
