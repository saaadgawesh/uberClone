import 'package:flutter/material.dart';
import 'package:uber/feature/Tabs/screens/home.dart';
import 'package:uber/feature/Tabs/screens/menu.dart';
import 'package:uber/feature/Tabs/screens/profile.dart';
import 'package:uber/feature/Tabs/screens/requests.dart';
import 'package:uber/feature/navBar/widgets/CustomButtomNavBar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 3;
  List<Widget> tabs = [Profile(), Requests(), Menu(), Home()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: Custombuttomnavbar(
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
