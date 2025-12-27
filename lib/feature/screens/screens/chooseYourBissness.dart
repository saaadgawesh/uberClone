import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/feature/screens/widgets/ChooseYourBussinessitem.dart';

class Chooseyourbissness extends StatelessWidget {
  const Chooseyourbissness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
          right: 20,
          left: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              customAppText(
                text: "choose",
                textColor: AppColor.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              customAppText(
                text: "choose your bissness and start your trip ",
                textColor: AppColor.greyColor,

                fontWeight: FontWeight.bold,
              ),
              ChooseYourBussinessitem(
                backGroundColor: AppColor.greyColor.withOpacity(0.3),
                title: "kaptin",
                text1: "accept trips and own",
                text2: "flexability work hours",
                text3: "owwwwwwwwwwwwwn",
                text4: "profesional support",
                textbutton: "kaptin",
                bgButtonColor: AppColor.blueColor,
                onpressed: () {},
                bgIconColor: AppColor.blueColor,
                icon: Icons.abc,
                iconcolor: AppColor.redColor,
                widthElevatedButton: appWidth(context) * 0.87,
              ),
              ChooseYourBussinessitem(
                backGroundColor: AppColor.greyColor.withOpacity(0.3),
                title: "customer",
                text1: "accept trips and own",
                text2: "flexability work hours",
                text3: "owwwwwwwwwwwwwn",
                text4: "profesional support",
                textbutton: "customer",
                bgButtonColor: AppColor.blueColor,
                onpressed: () {},
                bgIconColor: AppColor.blueColor,
                icon: Icons.abc,
                iconcolor: AppColor.redColor,
                widthElevatedButton: appWidth(context) * 0.87,
              ),
              customAppText(
                text: "choose your bissness and start your trip",
                textColor: AppColor.blackColor,
              ),
              customAppText(
                text: "start your trip today",
                textColor: AppColor.blackColor.withOpacity(0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
