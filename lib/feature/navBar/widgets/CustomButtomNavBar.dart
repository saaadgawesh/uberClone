import '../../../core/App_Imports/app_imports.dart';

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
    final applocalization = AppLocalizations.of(context)!;
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
            icon: Icon(Icons.house_siding_sharp),
            label: applocalization.home,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_sharp),
            label: applocalization.myrequests,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.car_crash_sharp),
            label: applocalization.requestcar,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: applocalization.profile,
          ),
        ],
      ),
    );
  }
}
