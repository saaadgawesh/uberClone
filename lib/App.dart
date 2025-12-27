import 'package:flutter/material.dart';
import 'package:uber/feature/screens/screens/PreviousReports.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Previousreports(),
      debugShowCheckedModeBanner: false,
    );
  }
}
