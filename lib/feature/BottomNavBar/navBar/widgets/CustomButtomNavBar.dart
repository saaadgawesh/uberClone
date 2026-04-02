import 'package:uberCloneDriver/core/Imports/app_imports.dart';

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
    Color bgcolor = Provider.of<SettingsProvider>(context).isDark
        ? AppColors.blackColor
        : AppColors.blueColor;

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
        selectedItemColor: AppColors.whiteColor,
        // ignore: deprecated_member_use
        unselectedItemColor: AppColors.whiteColor.withOpacity(0.5),
        selectedIconTheme: IconThemeData(size: 22),
        unselectedIconTheme: IconThemeData(size: 20),
        backgroundColor: bgcolor,
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alt_route),
            label: 'الرحلات',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: 'الإشعارات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: 'الإدارة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الحساب',
          ),
        ],
      ),
    );
  }
}
