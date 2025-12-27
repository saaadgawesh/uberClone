// ignore: file_names
import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/widgets/CustomContainer.dart';

class Processitem extends StatelessWidget {
  const Processitem({
    super.key,
    required this.title,
    required this.description,
    required this.leadIcon,
    required this.actionIcon,
    required this.backgroundColor,
  });
  final String title;
  final String description;
  final IconData leadIcon;
  final IconData actionIcon;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(15),
      height: 70,
      width: appWidth(context) * 0.9,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            // ignore: deprecated_member_use
            backgroundColor: AppColor.greyColor.withOpacity(0.4),
            radius: 20,
            child: customAppIcon(AppColor.whiteColor, leadIcon),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customAppText(text: title, textColor: AppColor.whiteColor),
              customAppText(text: description, textColor: AppColor.whiteColor),
            ],
          ),
          CustomContainer(
            actionIcon: actionIcon,
            height: 65,
            width: 50,
            borderRadius: BorderRadius.circular(10),
            bgContainerColor: AppColor.greyColor.withOpacity(0.4),
            child: customAppIcon(AppColor.whiteColor, actionIcon),
          ),
        ],
      ),
    );
  }
}
