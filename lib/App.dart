import 'package:flutter/material.dart';
import 'package:uberCloneRider/feature/navBar/screens/NavBar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const Navbar(), debugShowCheckedModeBanner: false);
  }
}
