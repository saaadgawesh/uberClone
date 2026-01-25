// ignore: file_names
import '../../../../core/App_Imports/app_imports.dart';

class Processitem extends StatelessWidget {
  const Processitem({
    super.key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.leadIcon,
    required this.actionIcon,
    required this.backgroundColor,
    this.child,
  });
  final String title;
  final String subtitle1;
  final String subtitle2;
  final IconData leadIcon;
  final IconData actionIcon;
  final Color backgroundColor;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(15),
      height: appHeight(context) * 0.2,
      width: appWidth(context) * 0.93,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: context.bgColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAppText(
                      text: title,
                      textColor: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                    VSpace(5),
                    CustomAppText(
                      text: subtitle1,
                      textColor: AppColors.whiteColor,
                    ),
                CustomAppText(
                      text: subtitle2,
                      textColor: AppColors.whiteColor,
                    ),
                  ],
                ),
              ],
            ),
          ),

          HSpace(5),
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
