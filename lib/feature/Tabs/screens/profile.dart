import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/constant/assets.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneRider/feature/Tabs/widgets/Processitem.dart';
import 'package:uberCloneRider/feature/Tabs/widgets/textfieldWithSectionTitle.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "profile"),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Processitem(
                title: "saadGawesh",
                description: "flutter developer",
                leadIcon: Icons.arrow_back,
                actionIcon: Icons.group,
                backgroundColor: AppColor.blueColor,
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
              heightSizedbox(10),
              Textfieldwithsectiontitle(text: 'from', hinttext: 'choose city'),
              heightSizedbox(10),
              Textfieldwithsectiontitle(text: 'to', hinttext: 'choose city'),
              heightSizedbox(10),
              Textfieldwithsectiontitle(
                text: 'tasneef',
                hinttext: 'choose city',
              ),
              heightSizedbox(10),
              Textfieldwithsectiontitle(
                text: 'type of transport',
                hinttext: 'choose city',
              ),
              heightSizedbox(10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultElevatedButton(
          textbutton: "AddYourAccount",
          bgButtonColor: AppColor.blueColor,
          onPressed: () {},
          width: appWidth(context),
          textcolor: AppColor.whiteColor,
        ),
      ),
    );
  }
}
