// ignore: file_names
import 'package:flutter/material.dart';
import 'package:uberCloneCustomer/core/constant/App_Color.dart';
import 'package:uberCloneCustomer/core/resources/App_Size.dart';
import 'package:uberCloneCustomer/core/resources/customAppIcon.dart';
import 'package:uberCloneCustomer/core/resources/customAppText.dart';
import 'package:uberCloneCustomer/core/widgets/CustomContainer.dart';

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
      height: appHeight(context) * 0.128,
      width: appWidth(context) * 0.93,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            // ignore: deprecated_member_use
            backgroundColor: AppColor.greyColor.withOpacity(0.4),
            radius: 20,
            child: customAppIcon(AppColor.whiteColor, leadIcon, 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customAppText(text: title, textColor: AppColor.whiteColor),
              customAppText(text: description, textColor: AppColor.whiteColor),
            ],
          ),
          if (child != null)
            CustomContainer(
              actionIcon: actionIcon,
              height: 65,
              width: 50,
              borderRadius: BorderRadius.circular(10),
              bgContainerColor: AppColor.greyColor,
              child: child!,
            ),
        ],
      ),
    );
  }
}
