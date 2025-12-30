import 'package:flutter/material.dart';
import 'package:uberCloneCustomer/feature/screens/screens/chooseYourBissness.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Chooseyourbissness(),
      debugShowCheckedModeBanner: false,
    );
  }
}
