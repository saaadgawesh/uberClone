import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';

class SearchingForDriverScreen extends StatelessWidget {
  final String tripId;

  const SearchingForDriverScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: " Searching for Driver",
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {
          Navigator.pop(context);
        },
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('trips')
            .doc(tripId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Trip not found'));
          }

          final tripData = snapshot.data!;
          final status = tripData['status'];

          return Center(child: Text('Trip Status: $status'));
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0),
        child: defaultElevatedButton(
          textbutton: "Choose Driver",
          bgButtonColor: AppColors.blueColor,
          onPressed: () {},
          width: appWidth(context),
          textcolor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
