import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/DefaultAppBar.dart';
import 'package:uber/core/widgets/defaultElevatedButton.dart';
import 'package:uber/feature/Tabs/widgets/Processitem.dart';
import 'package:uber/feature/Tabs/widgets/textfieldWithSectionTitle.dart';

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
                child: customAppIcon(AppColor.whiteColor, Icons.car_crash, 40),
              ),
              heightSizedbox(10),
              Textfieldwithsectiontitle(text: 'from', hinttext: 'choose city'),
              heightSizedbox(10),
              Textfieldwithsectiontitle(text: 'to', hinttext: 'choose city'),
              heightSizedbox(10),
              Textfieldwithsectiontitle(text: 'tasneef', hinttext: 'choose city'),
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
