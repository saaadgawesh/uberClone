import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';

class Custombuttomnavbar extends StatelessWidget {
  const Custombuttomnavbar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });
  final void Function(int) onTap;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
      ),
      child: BottomNavigationBar(
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        selectedItemColor: AppColor.whiteColor,
        // ignore: deprecated_member_use
        unselectedItemColor: AppColor.whiteColor.withOpacity(0.5),
        selectedIconTheme: IconThemeData(size: 22),
        unselectedIconTheme: IconThemeData(size: 20),
        backgroundColor: AppColor.blueColor,
        currentIndex: currentIndex,
        onTap: onTap,
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
