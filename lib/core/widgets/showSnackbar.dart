import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/customAppText.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
  BuildContext context,
  String title,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.redColor,
      content: CustomAppText(
        text: title,
        textAlign: TextAlign.center,
        textColor: AppColors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
