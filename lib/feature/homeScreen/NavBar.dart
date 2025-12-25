import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/feature/Tabs/screens/home.dart';
import 'package:uber/feature/Tabs/screens/menu.dart';
import 'package:uber/feature/Tabs/screens/profile.dart';
import 'package:uber/feature/Tabs/screens/requests.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;
  List<Widget> tabs = [Profile(), Requests(), Menu(), Home()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: DefaultAppBar(
      //   actiontitle: 'welcome',
      //   actionDesc: 'welcome',
      //   actionOntap: () {},
      //   leadingonTap: () {},
      // ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        selectedItemColor: AppColor.blueColor,
        currentIndex: _currentIndex,
        onTap: (value) {
          _currentIndex = value;
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash_sharp),
            label: 'requests',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'menu'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        ],
      ),
    );
  }
}
