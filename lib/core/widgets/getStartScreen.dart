   import 'package:uberCloneDriver/core/Imports/app_imports.dart';

Widget getStartScreen() {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return const Navbar();
      } else {
        return const LoginScreen();
      }
    }
