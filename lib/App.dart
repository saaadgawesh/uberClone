import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/appThem.dart';
import 'package:uberCloneRider/feature/screens/Location/Location_Screen/LocationScreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Locationscreen(),
      debugShowCheckedModeBanner: false,
      theme: Appthem.lighttheme,
      themeMode: ThemeMode.light,
      darkTheme: Appthem.lighttheme,
    );
  }
}
