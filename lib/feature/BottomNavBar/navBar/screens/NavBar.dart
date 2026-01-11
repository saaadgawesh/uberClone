import 'package:flutter/material.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/screens/Reports.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/screens/home.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/screens/profile.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/screens/requests.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/navBar/widgets/CustomButtomNavBar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 3;
  List<Widget> tabs = [
    const Profile(),
    Requests(),
    const Reports(),
    const Home(),
  ];
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
