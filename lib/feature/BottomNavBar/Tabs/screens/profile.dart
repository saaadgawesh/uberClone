import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/constant/assets.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneDriver/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneDriver/core/widgets/spacing.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/Processitem.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/textfieldWithSectionTitle.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "profile",

        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Processitem(
                title: "saadGawesh",
                description: "flutter developer",
                leadIcon: Icons.edit,

                actionIcon: Icons.group,
                backgroundColor: AppColors.blueColor,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(5),
                  child: Image.asset(
                    Assets.photo,
                    width: appWidth(context),
                    height: appHeight(context),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

                     VSpace(10),
              Textfieldwithsectiontitle(
                text: 'tasneef',
                hinttext: 'choose city',
              ),
                     VSpace(10),
              Textfieldwithsectiontitle(
                text: 'type of transport',
                hinttext: 'choose city',
              ),
                     VSpace(10),
              defaultElevatedButton(
                textbutton: "End Trip",
                bgButtonColor: AppColors.blueColor,
                onPressed: () async {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser == null) return;

                  final driverDoc = FirebaseFirestore.instance
                      .collection('Driver')
                      .doc(currentUser.uid);

                  try {
                    // تحديث حالة السائق إلى available
                    await driverDoc.update({'status': 'available'});

                    // اختياري: رسالة للمستخدم
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.greenColor,
                        content: Text("Trip ended. You are now available!"),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error: $e")));
                  }
                },
                width: appWidth(context),
                textcolor: AppColors.whiteColor,
              ),
              VSpace(10),
              defaultElevatedButton(
                textbutton: "Unavailable",
                bgButtonColor: AppColors.error,
                onPressed: () async {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser == null) return;

                  final driverDoc = FirebaseFirestore.instance
                      .collection('Driver')
                      .doc(currentUser.uid);

                  try {
                    await driverDoc.update({'status': 'busy'});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.error,
                        content: Text("You are now unavailable for new trips."),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error: $e")));
                  }
                },
                width: appWidth(context),
                textcolor: AppColors.whiteColor,
              ),
              VSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
