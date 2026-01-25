import "../../core/App_Imports/app_imports.dart";

// ignore: non_constant_identifier_names
Widget CustomServiceWidget(BuildContext context, int index) {
  final applocalization = AppLocalizations.of(context)!;
  List<String> titles = [
    applocalization.myboket,
    applocalization.mytrip,
    applocalization.thelastTrips,
    applocalization.offers,
  ];
  List<String> desc = [
    applocalization.paidManaged,
    applocalization.tripsFollow,
    applocalization.riders,
    applocalization.offersmanage,
  ];
  List<IconData> icons = [
    Icons.wallet,
    Icons.alarm,
    Icons.menu,
    Icons.accessibility_new_sharp,
  ];
  SettingsProvider settingsProvider = Provider.of(context);
  return CustomContainer(
    height: 50,
    width: 50,
    borderRadius: BorderRadius.circular(10),
    bgContainerColor: AppColors.greyColor.withOpacity(0.2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomContainer(
          height: 40,
          width: 40,
          borderRadius: BorderRadius.circular(10),
          bgContainerColor: settingsProvider.isDark
              ? AppColors.blackColorwithopacity
              : AppColors.blueColor,
          child: customAppIcon(
            iconName: icons[index],
            iconColor: AppColors.whiteColor,
          ),
        ),

        VSpace(8),
        CustomAppText(
          text: titles[index],
          textColor: settingsProvider.isDark
              ? AppColors.blackColor
              : AppColors.blueColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        CustomAppText(
          text: desc[index],
          textColor: settingsProvider.isDark
              ? AppColors.blackColorwithopacity
              : AppColors.blueColorwithopacity,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
