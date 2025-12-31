import 'package:flutter/material.dart';
import 'package:uberCloneRider/feature/landingPages/landingPage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Landingpage(), debugShowCheckedModeBanner: false);
  }
}
