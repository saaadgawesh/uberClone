import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/CustomContainer.dart';

// ignore: non_constant_identifier_names
Widget CustomServiceWidget(BuildContext context) {
  return CustomContainer(
    height: appHeight(context) * 0.25,
    width: appWidth(context) * 0.4,
    borderRadius: BorderRadius.circular(10),
    bgContainerColor: AppColor.greyColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomContainer(
          height: 40,
          width: 40,
          borderRadius: BorderRadius.circular(10),
          bgContainerColor: AppColor.blueColor,
          child: customAppIcon(AppColor.whiteColor, Icons.alarm),
        ),

        heightSizedbox(8),
        customAppText(
          text: 'data',
          textColor: AppColor.blackColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        customAppText(
          text: 'data',
          textColor: AppColor.blackColor.withOpacity(0.3),
        ),
      ],
    ),
  );
}
