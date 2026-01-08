import 'package:flutter/material.dart';
import 'package:uberCloneRider/feature/Tabs/screens/home.dart';
import 'package:uberCloneRider/feature/Tabs/screens/myRequests.dart';
import 'package:uberCloneRider/feature/Tabs/screens/profile.dart';
import 'package:uberCloneRider/feature/Tabs/screens/requestCar.dart';
import 'package:uberCloneRider/feature/navBar/widgets/CustomButtomNavBar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 3;
  final List<Widget> _tabs = [
    const Profile(),
    const Requestcar(),
    const Myrequests(),
    const Home(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
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
