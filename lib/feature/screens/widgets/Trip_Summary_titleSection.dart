
import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/customAppText.dart';
import 'package:uberCloneRider/core/widgets/CustomContainer.dart';

class TripSummarytitleSection extends StatelessWidget {
  const TripSummarytitleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(10),
      bgContainerColor: AppColor.blackColor,
      height: appHeight(context) * 0.1,
      width: appWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppText(
            text: "Distance",
            textColor: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          CustomAppText(
            text: "Duration",
            textColor: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          CustomAppText(
            text: "Price",
            textColor: AppColor.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
