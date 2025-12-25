import 'package:flutter/material.dart';
import 'package:uber/feature/homeScreen/NavBar.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Navbar(), debugShowCheckedModeBanner: false);
  }
}
