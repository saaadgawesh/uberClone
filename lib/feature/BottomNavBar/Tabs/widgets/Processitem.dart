// ignore: file_names
import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/resources/CustomAppText.dart';
import 'package:uberCloneDriver/core/resources/customAppIcon.dart';
import 'package:uberCloneDriver/core/resources/sizedboxWidget.dart';
import 'package:uberCloneDriver/core/widgets/CustomContainer.dart';

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
    return CustomContainer(
      padding: EdgeInsets.all(15),
      height: appHeight(context) * 0.19,
      width: appWidth(context) * 0.93,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            // ignore: deprecated_member_use
            backgroundColor: AppColors.greyColor.withOpacity(0.4),
            radius: 20,
            child: customAppIcon(
              iconName: leadIcon,
              iconColor: AppColors.whiteColor,
            ),
          ),
          Container(
            width: appWidth(context) * 0.5,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomAppText(text: title, textColor: AppColors.whiteColor),
                    heightSizedbox(5),
                    CustomAppText(
                      text: description,
                      textColor: AppColors.whiteColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          widthSizedbox(5),
          if (child != null)
            CustomContainer(
              actionIcon: actionIcon,
              height: appHeight(context),
              width: appWidth(context) * 0.15,
              borderRadius: BorderRadius.circular(10),
              bgContainerColor: AppColors.greyColor,
              child: child!,
            ),
        ],
      ),
    );
  }
}
