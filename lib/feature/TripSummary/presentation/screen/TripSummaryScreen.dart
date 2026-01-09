import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/constant/assets.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneRider/feature/TripSummary/data/models/tripModel.dart';
import 'package:uberCloneRider/feature/TripSummary/presentation/screen/SearchingForDriverScreen.dart';
import 'package:uberCloneRider/feature/TripSummary/presentation/widgets/TripSummaryDetalis.dart';
import 'package:uberCloneRider/feature/TripSummary/presentation/widgets/Trip_Summary_titleSection.dart';

class TripSummaryScreen extends StatelessWidget {
  final TripData tripData;

  const TripSummaryScreen({super.key, required this.tripData});

  // ================= CREATE TRIP =================
  Future<String> createTrip() async {
    final tripRef = FirebaseFirestore.instance.collection('trips').doc();

    await tripRef.set({
      "riderId": "USER_ID",
      "driverId": null,

      // للسواق
      "startLocation": {
        "lat": tripData.startLocation.latitude,
        "lng": tripData.startLocation.longitude,
      },
      "endLocation": {
        "lat": tripData.endLocation.latitude,
        "lng": tripData.endLocation.longitude,
      },

      // للراكب
      "startAddress": tripData.startAddress,
      "endAddress": tripData.endAddress,

      "distanceKm": tripData.distanceKm,
      "durationMin": tripData.durationMin,
      "price": tripData.price,

      "status": "searching",
      "createdAt": FieldValue.serverTimestamp(),
    });

    return tripRef.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Trip Summary",
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                Assets.car1,
                width: appWidth(context),
                height: appHeight(context) * 0.24,
                fit: BoxFit.cover,
              ),
            ),
            heightSizedbox(5),
            const TripSummarytitleSection(),
            heightSizedbox(5),

            /// 👇 مصدر البيانات واحد
            TripSummaryDetalis(tripData: tripData),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0),
        child: defaultElevatedButton(
          height: appHeight(context) * 0.09,
          textbutton: 'Create Trip',
          bgButtonColor: AppColors.blueColor,
          width: appWidth(context),
          textcolor: AppColors.whiteColor,
          onPressed: () async {
            final tripId = await createTrip();

            // الانتقال لشاشة انتظار السائق بعد إنشاء الرحلة
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => SearchingForDriverScreen(tripId: tripId),
              ),
            );
          },
        ),
      ),
    );
  }
}
