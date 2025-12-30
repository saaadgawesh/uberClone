import 'package:flutter/material.dart';
import 'package:uberCloneCustomer/core/constant/App_Color.dart';
import 'package:uberCloneCustomer/core/resources/App_Size.dart';
import 'package:uberCloneCustomer/core/resources/customAppText.dart';
import 'package:uberCloneCustomer/feature/navBar/screens/NavBar.dart';
import 'package:uberCloneCustomer/feature/screens/widgets/ChooseYourBussinessitem.dart';

class Chooseyourbissness extends StatelessWidget {
  const Chooseyourbissness({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 50,
          bottom: 20,
          right: 20,
          left: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customAppText(
                text: "Choose",
                textColor: AppColor.blackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: customAppText(
                  text: "choose your bissness and start your trip ",
                  textColor: AppColor.greyColor,

                  fontWeight: FontWeight.bold,
                ),
              ),
              ChooseYourBussinessitem(
                backGroundColor: AppColor.greyColor,
                title: "kaptin",
                text1: "accept trips and own",
                text2: "flexability work hours",
                text3: "owwwwwwwwwwwwwn",
                text4: "profesional support",
                textbutton: "kaptin",
                bgButtonColor: AppColor.blueColor,
                onpressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Navbar()));
                },
                bgIconColor: AppColor.blueColor,
                icon: Icons.abc,
                iconcolor: AppColor.redColor,
                widthElevatedButton: appWidth(context) * 0.87,
              ),
              ChooseYourBussinessitem(
                backGroundColor: AppColor.greyColor,
                title: "customer",
                text1: "accept trips and own",
                text2: "flexability work hours",
                text3: "owwwwwwwwwwwwwn",
                text4: "profesional support",
                textbutton: "customer",
                bgButtonColor: AppColor.blueColor,
                onpressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => Navbar()));
                },
                bgIconColor: AppColor.blueColor,
                icon: Icons.abc,
                iconcolor: AppColor.redColor,
                widthElevatedButton: appWidth(context) * 0.87,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: customAppText(
                  text: "choose your bissness and start your trip",
                  textColor: AppColor.blackColor,
                ),
              ),
              customAppText(
                text: "start your trip today",
                textColor: AppColor.blackColorwithopacity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
