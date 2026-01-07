import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/constant/assets.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneRider/feature/screens/widgets/Trip_Summary_titleSection.dart';
import 'package:uberCloneRider/feature/screens/widgets/TripSummaryDetalis.dart';

class TripSummaryScreen extends StatelessWidget {
  final LatLng start;
  final LatLng end;
  final double distance;
  final double duration;
  final double price;

  const TripSummaryScreen({
    super.key,
    required this.start,
    required this.end,
    required this.distance,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Trip Summary",
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Image.asset(Assets.car1),
            ),
            TripSummarytitleSection(),
            heightSizedbox(8),
            TripSummaryDetalis(
              distance: distance,
              duration: duration,
              price: price,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0),
        child: defaultElevatedButton(
          height: appHeight(context) * 0.09,
          textbutton: 'ok !',
          bgButtonColor: AppColor.blueColor,
          onPressed: () {},
          width: appWidth(context),
          textcolor: AppColor.whiteColor,
        ),
      ),
    );
  }
}
