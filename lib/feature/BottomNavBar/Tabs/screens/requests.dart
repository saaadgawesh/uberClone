import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/AppDivider.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/resources/customAppText.dart';
import 'package:uberCloneDriver/core/widgets/CustomContainer.dart';
import 'package:uberCloneDriver/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneDriver/core/widgets/spacing.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/DriverRepository.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/acceptTrip.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/openMaps.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/rejectTrip.dart';

class Requests extends StatelessWidget {
  final DriverRepository driverRepo = DriverRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'طلباتك',
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: driverRepo.getDriverTrips(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('لا توجد طلبات جديدة'));
          }

          final trips = snapshot.data!.docs;

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index].data();

              final double fromLat = (trip['fromLat'] as num).toDouble();
              final double fromLng = (trip['fromLng'] as num).toDouble();
              final double toLat = (trip['toLat'] as num).toDouble();
              final double toLng = (trip['toLng'] as num).toDouble();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomContainer(
                  padding: EdgeInsets.all(10),
                  height: appHeight(context) * 0.3249,
                  width: appWidth(context),
                  bgContainerColor: AppColors.blueColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomAppText(
                                text: 'price: ${' السعر: ${trip['price']}'}',
                                textColor: AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      VSpace(15),
                      AppDivider(color: AppColors.whiteColor),
                      VSpace(10),

                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.red),
                            SizedBox(width: 8),
                            CustomAppText(
                              text: "Open Route in Maps",
                              textColor: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),

                      VSpace(15),
                      AppDivider(color: AppColors.whiteColor),
                      VSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              acceptTrip(trips[index].id);
                              openRouteInGoogleMaps(
                                fromLat: fromLat,
                                fromLng: fromLng,
                                toLat: toLat,
                                toLng: toLng,
                              );
                            },
                            child: CustomContainer(
                              bgContainerColor: AppColors.greenColor,
                              height: appHeight(context) * 0.07,
                              width: appWidth(context) * 0.4,
                              child: CustomAppText(
                                text: "Accepted",
                                textColor: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              rejectTrip(trips[index].id);
                            },
                            child: CustomContainer(
                              bgContainerColor: AppColors.redColor,
                              height: appHeight(context) * 0.07,
                              width: appWidth(context) * 0.4,
                              child: CustomAppText(
                                text: "Rejected",
                                textColor: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
