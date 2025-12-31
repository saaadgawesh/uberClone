import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/constant/assets.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/CustomAppText.dart';
import 'package:uberCloneRider/core/resources/customAppIcon.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/CustomServiceWidget.dart';
import 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneRider/feature/Tabs/widgets/Processitem.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    bool cached = false;
    return Scaffold(
      appBar: DefaultAppBar(
        actiontitle: 'welcome mazen',
        actionDesc: 'where you want going to?',
        actionOntap: () {},
        leadingonTap: () {},
        leadIconName: Icons.person,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomAppText(
                text: "start your journey",
                textColor: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              Processitem(
                title: "are you ready?",
                description: "request your car and join with good trip",
                leadIcon: Icons.arrow_back,
                actionIcon: Icons.group,
                backgroundColor: AppColor.blueColor,
                child: customAppIcon(AppColor.whiteColor, Icons.car_crash, 40),
              ),

              heightSizedbox(10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                ),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return CustomServiceWidget(context);
                },
              ),
              heightSizedbox(10),

              CustomAppText(
                text: "alnashatat al akhitah",
                textColor: AppColor.blackColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),

              Center(
                child: Column(
                  children: [
                    cached == true
                        ? CachedNetworkImage(
                            width: appWidth(context),
                            height: appHeight(context),
                            imageUrl:
                                "https://www.shutterstock.com/image-vector/envelope-document-exclamation-mark-icon-new-1558918442",
                          )
                        : Image.asset(
                            Assets.homeImage,
                            fit: BoxFit.cover,
                            width: appWidth(context) * 0.6,
                            height: appHeight(context) * 0.3,
                          ),
                    CustomAppText(
                      text: "alnashatat al akhitah",
                      textColor: AppColor.blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    CustomAppText(
                      text: "alnashatat al akhitah",
                      textColor: AppColor.blackColor,

                      fontSize: 16,
                    ),
                  ],
                ),
              ),
              heightSizedbox(10),
            ],
          ),
        ),
      ),
    );
  }
}
