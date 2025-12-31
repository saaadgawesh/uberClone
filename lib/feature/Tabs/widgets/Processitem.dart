// ignore: file_names
import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/customAppIcon.dart';
import 'package:uberCloneRider/core/resources/CustomAppText.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/CustomContainer.dart';

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
      padding: EdgeInsets.all(10),
      height: appHeight(context) * 0.16,
      width: appWidth(context) * 0.93,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: backgroundColor,
      child: Row(
        children: [
          CircleAvatar(
            // ignore: deprecated_member_use
            backgroundColor: AppColor.greyColor.withOpacity(0.4),
            radius: 20,
            child: customAppIcon(AppColor.whiteColor, leadIcon, 20),
          ),
          Container(
            alignment: Alignment.bottomRight,
            width: appWidth(context) * 0.51,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAppText(text: title, textColor: AppColor.whiteColor),
                heightSizedbox(5),
                Flexible(
                  child: CustomAppText(
                    text: description,
                    textColor: AppColor.whiteColor,
                    overflow: TextOverflow.visible,

                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          widthSizedbox(5),
          if (child != null)
            CustomContainer(
              actionIcon: actionIcon,
              height: appHeight(context),
              width: appWidth(context) * 0.18,
              borderRadius: BorderRadius.circular(10),
              bgContainerColor: AppColor.greyColor,
              child: child!,
            ),
        ],
      ),
    );
  }
}
