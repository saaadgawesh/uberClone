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
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
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
                child:
                    //  Stack(
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 55,
                    //       backgroundImage: AssetImage(Assets.photo),
                    //     ),
                    //     Positioned(
                    //       right: 0,
                    //       bottom: 5,
                    //       child: Image(
                    //         image: AssetImage(Assets.homeImage),
                    //         width: 18,
                    //         height: 18,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    ClipOval(
                      // borderRadius: BorderRadiusGeometry.circular(5),
                      child: Image.asset(
                        Assets.photo,
                        width: appWidth(context),
                        height: appHeight(context),
                        fit: BoxFit.cover,
                      ),
                    ),
              ),
              heightSizedbox(10),
              Textfieldwithsectiontitle(text: 'Name', hinttext: 'saadGawesh'),
              heightSizedbox(10),
              Textfieldwithsectiontitle(
                text: 'phoneNo',
                hinttext: '01031214881',
              ),
              heightSizedbox(10),
              Textfieldwithsectiontitle(
                text: 'Email',
                hinttext: 'Saadgawesh@gmail.com',
              ),
              heightSizedbox(10),
              Textfieldwithsectiontitle(
                text: 'your job',
                hinttext: 'flutter developer',
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
          bgButtonColor: AppColors.blueColor,
          onPressed: () {},
          width: appWidth(context),
          textcolor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
