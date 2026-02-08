import '../../core/App_Imports/app_imports.dart';

Widget getStartScreen() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return const Navbar();
  } else {
    return const SplashScreen();
  }
}
