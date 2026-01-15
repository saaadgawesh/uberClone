import 'package:uberCloneDriver/core/Imports/app_imports.dart';

class Processitem extends StatelessWidget {
  const Processitem({
    super.key,
    required this.title,
    required this.description,
    required this.leadIcon,
    required this.actionIcon,
    required this.backgroundColor,
    this.child,
  });
  final String title;
  final String description;
  final IconData leadIcon;
  final IconData actionIcon;
  final Color backgroundColor;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return CustomContainer(
      padding: EdgeInsets.all(15),
      height: appHeight(context) * 0.2,
      width: appWidth(context) * 0.93,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: settingsProvider.isdark
          ? AppColors.blackColorwithopacity
          : AppColors.blueColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HSpace(5),
          if (child != null)
            CustomContainer(
              actionIcon: actionIcon,
              height: appHeight(context),
              width: appWidth(context) * 0.15,
              borderRadius: BorderRadius.circular(10),
              bgContainerColor: AppColors.greyColor,
              child: child!,
            ),

          SizedBox(
            width: appWidth(context) * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAppText(text: title, textColor: AppColors.whiteColor),
                VSpace(5),
                CustomAppText(
                  text: description,
                  textColor: AppColors.whiteColor,
                ),
              ],
            ),
          ),

          CircleAvatar(
            // ignore: deprecated_member_use
            backgroundColor: AppColors.greyColor.withOpacity(0.4),
            radius: 20,
            child: customAppIcon(
              iconName: leadIcon,
              iconColor: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
