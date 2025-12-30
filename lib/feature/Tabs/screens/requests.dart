import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/DefaultAppBar.dart';
import 'package:uber/core/widgets/defaultElevatedButton.dart';
import 'package:uber/feature/Tabs/widgets/textfieldWithSectionTitle.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'request cars'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              heightSizedbox(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customAppText(
                    text: "350Eg",
                    textColor: AppColor.greenColor,

                    fontWeight: FontWeight.w500,
                  ),
                  customAppText(
                    text: "tripPrice",
                    textColor: AppColor.blueColor,

                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              heightSizedbox(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customAppText(
                    text: "time",
                    textColor: AppColor.blueColor,

                    fontWeight: FontWeight.w500,
                  ),
                  customAppText(
                    text: "date",
                    textColor: AppColor.blueColor,

                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  defaultElevatedButton(
                    textbutton: "PM 06:46",
                    bgButtonColor: AppColor.greyColor,
                    onPressed: () {},
                    iconName: Icons.alarm,
                    iconColor: AppColor.blackColorwithopacity,
                    width: appWidth(context) * 0.47,
                    textcolor: AppColor.blackColorwithopacity,
                  ),
                  defaultElevatedButton(
                    textbutton: "25-11-16",
                    bgButtonColor: AppColor.greyColor,
                    onPressed: () {},
                    iconName: Icons.date_range,
                    iconColor: AppColor.blackColorwithopacity,
                    width: appWidth(context) * 0.47,
                    textcolor: AppColor.blackColorwithopacity,
                  ),
                ],
              ),
              heightSizedbox(10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultElevatedButton(
          textbutton: "request now",
          bgButtonColor: AppColor.blueColor,
          onPressed: () {},

          width: appWidth(context),
          textcolor: AppColor.whiteColor,
        ),
      ),
    );
  }
}
