import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/resources/customAppText.dart';
import 'package:uberCloneDriver/core/widgets/CustomContainer.dart';

class TripSummarytitleSection extends StatelessWidget {
  const TripSummarytitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(10),
      bgContainerColor: AppColors.blackColor,
      height: appHeight(context) * 0.09,
      width: appWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppText(
            text: "Distance",
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          CustomAppText(
            text: "Duration",
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          CustomAppText(
            text: "Price",
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
