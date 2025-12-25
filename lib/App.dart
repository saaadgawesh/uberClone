import 'package:flutter/material.dart';
import 'package:uber/feature/homeScreen/homeScreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Homescreen(), debugShowCheckedModeBanner: false);
  }
}
