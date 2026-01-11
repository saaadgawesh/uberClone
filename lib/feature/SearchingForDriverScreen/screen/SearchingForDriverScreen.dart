import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/constant/assets.dart';
import 'package:uberCloneRider/core/extension/navigation.dart';
import 'package:uberCloneRider/core/resources/AppDivider.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/customAppText.dart';
import 'package:uberCloneRider/core/routing/routes.dart';
import 'package:uberCloneRider/core/widgets/CustomContainer.dart';
import 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneRider/core/widgets/spacing.dart';
import 'package:uberCloneRider/feature/TripSummary/TripRepository.dart';
import 'package:uberCloneRider/feature/TripSummary/data/models/tripModel.dart';

class SearchingForDriverScreen extends StatefulWidget {
  const SearchingForDriverScreen({super.key});

  @override
  State<SearchingForDriverScreen> createState() =>
      _SearchingForDriverScreenState();
}

class _SearchingForDriverScreenState extends State<SearchingForDriverScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // استقبال tripData من ModalRoute
  }

  String? selectedDriverId; // السواق المختار
  bool isLoading = true;
  List<QueryDocumentSnapshot> drivers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Searching for Driver",
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () => Navigator.pop(context),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Driver')
            .where('status', isEqualTo: 'available')
            .where('isOnline', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              drivers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            drivers = snapshot.data!.docs;
            isLoading = false;
          }

          if (drivers.isEmpty && !isLoading) {
            return const Center(child: Text("No drivers available"));
          }

          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              final driverId = driver.id;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDriverId = driverId; // اختيار السواق
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomContainer(
                    padding: EdgeInsets.all(10),
                    height: appHeight(context) * 0.26,
                    width: appWidth(context),
                    bgContainerColor: selectedDriverId == driverId
                        ? Colors.blue.withOpacity(0.7)
                        : AppColors.blueColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(Assets.homeImage),
                              backgroundColor: AppColors.whiteColor,
                              radius: 35,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomAppText(
                                  text:
                                      'Name: ${driver['name']?.toString() ?? 'Unknown'}',
                                  textColor: AppColors.whiteColor,
                                ),
                                CustomAppText(
                                  text:
                                      'Car Model: ${driver['carModel']?.toString() ?? 'Unknown'}',
                                  textColor: AppColors.whiteColor,
                                ),
                                CustomAppText(
                                  text:
                                      'Car Number: ${driver['carNumber']?.toString() ?? 'Unknown'}',
                                  textColor: AppColors.whiteColor,
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                final repo = TripRepository();
                                final tripData =
                                    ModalRoute.of(context)!.settings.arguments
                                        as TripData;
                                if (selectedDriverId == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Please select a driver first",
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                await repo.selectDriver(
                                  tripData,
                                  selectedDriverId!,
                                );
                                print(
                                  "=====================================${driverId}",
                                );
                                context.pushNamed(Routes.navbar);
                              },
                              child: CircleAvatar(
                                backgroundColor: AppColors.whiteColor,
                                child: CustomAppText(text: "OK"),
                              ),
                            ),
                          ],
                        ),
                        VSpace(15),
                        AppDivider(color: AppColors.whiteColor),
                        VSpace(10),
                        CustomAppText(
                          text:
                              'Location: ${driver['location']?.toString() ?? 'Unknown'}',
                          textColor: AppColors.whiteColor,
                        ),
                      ],
                    ),
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
