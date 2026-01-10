import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/CustomAppText.dart';

class TripSummaryDetalisItem extends StatelessWidget {
  const TripSummaryDetalisItem({
    super.key,
    required this.title,
    required this.distancetext,
  });

  final String title;
  final String distancetext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomAppText(text: title, textColor: AppColors.whiteColor),
        CustomAppText(text: distancetext, textColor: AppColors.whiteColor),
      ],
    );
  }
}
