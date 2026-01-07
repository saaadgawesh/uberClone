import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/CustomAppText.dart';
import 'package:uberCloneRider/core/widgets/CustomContainer.dart';

class TripSummaryDetalis extends StatelessWidget {
  const TripSummaryDetalis({
    super.key,
    required this.distance,
    required this.duration,
    required this.price,
  });

  final double distance;
  final double duration;
  final double price;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(10),
      bgContainerColor: AppColor.blueColor,
      height: appHeight(context) * 0.2,
      width: appWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TripSummaryDetalisItem(distancetext: 'km', distance: distance),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppText(
                text: "${duration.toStringAsFixed(1)}",
                textColor: AppColor.whiteColor,
              ),
              CustomAppText(text: " min", textColor: AppColor.whiteColor),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAppText(
                text: "${price.toStringAsFixed(2)} ",
                textColor: AppColor.whiteColor,
              ),
              CustomAppText(text: "EGP", textColor: AppColor.whiteColor),
            ],
          ),
        ],
      ),
    );
  }
}

class TripSummaryDetalisItem extends StatelessWidget {
  const TripSummaryDetalisItem({
    super.key,
    required this.distance,
    required this.distancetext,
  });

  final double distance;
  final String distancetext;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomAppText(
          text: "${distance.toStringAsFixed(2)} ",
          textColor: AppColor.whiteColor,
        ),
        CustomAppText(text: distancetext, textColor: AppColor.whiteColor),
      ],
    );
  }
}
