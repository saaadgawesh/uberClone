import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/constant/assets.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneRider/feature/screens/TripSummaryScreen/widgets/TripSummaryDetalis.dart';
import 'package:uberCloneRider/feature/screens/TripSummaryScreen/widgets/Trip_Summary_titleSection.dart';

class TripSummaryScreen extends StatelessWidget {
  final LatLng? start;
  final LatLng? end;
  final double? distance;
  final double? duration;
  final double? price;

  const TripSummaryScreen({
    super.key,
    this.start,
    this.end,
    this.distance,
    this.duration,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Trip Summary",
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Image.asset(
                Assets.car1,
                width: appWidth(context),
                height: appHeight(context) * 0.3,
              ),
            ),
            heightSizedbox(8),
            TripSummarytitleSection(),
            heightSizedbox(8),
            TripSummaryDetalis(
              distance: distance ?? 0,
              duration: duration ?? 0,
              price: price ?? 0,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0),
        child: defaultElevatedButton(
          height: appHeight(context) * 0.09,
          textbutton: 'ok !',
          bgButtonColor: AppColors.blueColor,
          onPressed: () {},
          width: appWidth(context),
          textcolor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
