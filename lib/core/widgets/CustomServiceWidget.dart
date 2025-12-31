import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/CustomAppText.dart';
import 'package:uberCloneRider/core/resources/customAppIcon.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/CustomContainer.dart';

// ignore: non_constant_identifier_names
Widget CustomServiceWidget(BuildContext context) {
  return CustomContainer(
    height: 50,
    width: 50,
    borderRadius: BorderRadius.circular(10),
    bgContainerColor: AppColor.greyColor.withOpacity(0.2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomContainer(
          height: 40,
          width: 40,
          borderRadius: BorderRadius.circular(10),
          bgContainerColor: AppColor.blueColor,
          child: customAppIcon(AppColor.whiteColor, Icons.alarm, 20),
        ),

        heightSizedbox(8),
        CustomAppText(
          text: 'data',
          textColor: AppColor.blackColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        CustomAppText(text: 'data', textColor: AppColor.blackColorwithopacity),
      ],
    ),
  );
}
