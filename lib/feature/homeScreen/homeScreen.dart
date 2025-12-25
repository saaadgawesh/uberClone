import 'package:flutter/material.dart';
import 'package:uber/core/widgets/custom_AppBar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'الاشتراكات',  actionOntap: () {  }, leadingonTap: () {  },),
      body: Padding(padding: const EdgeInsets.all(20.0)),
    );
  }
}
