import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/widgets/CustomContainer.dart';
import 'package:uberCloneRider/feature/screens/TripSummaryScreen/widgets/TripSummaryDetalisItem.dart';

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
      bgContainerColor: AppColors.blueColor,
      height: appHeight(context) * 0.2,
      width: appWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TripSummaryDetalisItem(
            distancetext: 'km',
            title: distance.toStringAsFixed(2),
          ),
          // Column(
          TripSummaryDetalisItem(
            distancetext: 'min',
            title: duration.toStringAsFixed(1),
          ),
          TripSummaryDetalisItem(
            distancetext: 'EGP',
            title: price.toStringAsFixed(2),
          ),
        ],
      ),
    );
  }
}
