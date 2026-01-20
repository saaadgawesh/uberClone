import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/AppDivider.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/resources/customAppText.dart';
import 'package:uberCloneDriver/core/widgets/CustomContainer.dart';
import 'package:uberCloneDriver/feature/TripSummary/data/models/tripModel.dart';
import 'package:uberCloneDriver/feature/TripSummary/presentation/widgets/TripSummaryDetalisItem.dart';

class TripSummaryDetalis extends StatelessWidget {
  const TripSummaryDetalis({super.key, required this.tripmodel});

  final Tripmodel tripmodel;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(10),
      bgContainerColor: AppColors.blueColor,
      height: appHeight(context) * 0.33,
      width: appWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// distance / duration / price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TripSummaryDetalisItem(
                distancetext: 'km',
                title: tripmodel.distanceKm.toStringAsFixed(2),
              ),
              TripSummaryDetalisItem(
                distancetext: 'min',
                title: tripmodel.durationMin.toStringAsFixed(1),
              ),
              TripSummaryDetalisItem(
                distancetext: 'EGP',
                title: tripmodel.price.toStringAsFixed(2),
              ),
            ],
          ),

          const SizedBox(height: 8),
          AppDivider(color: AppColors.whiteColor),
          const SizedBox(height: 8),

          CustomAppText(
            text: "Start: ",
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
          Expanded(
            child: Text(
              tripmodel.startAddress,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 2),
          AppDivider(color: AppColors.whiteColor),
          const SizedBox(height: 2),
          CustomAppText(
            text: "End: ",
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
          Expanded(
            child: Text(
              tripmodel.endAddress,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
