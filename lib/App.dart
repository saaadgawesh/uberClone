import 'package:flutter/material.dart';
import 'package:uber/feature/presentation/screens/LocationScreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Locationscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
