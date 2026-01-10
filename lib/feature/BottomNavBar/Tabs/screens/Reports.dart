import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/resources/CustomAppText.dart';
import 'package:uberCloneDriver/core/resources/sizedboxWidget.dart';
import 'package:uberCloneDriver/core/widgets/CustomCounter.dart';
import 'package:uberCloneDriver/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneDriver/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneDriver/feature/BottomNavBar/Tabs/widgets/textfieldWithSectionTitle.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'kashf Al rokab'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppText(
              text: "text",
              textColor: AppColors.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            Textfieldwithsectiontitle(text: 'from', hinttext: 'choose city'),
            heightSizedbox(10),
            Textfieldwithsectiontitle(text: 'to', hinttext: 'choose city'),
            heightSizedbox(10),
            CustomAppText(
              text: "custumer number",
              textColor: AppColors.blueColor,

              fontWeight: FontWeight.w500,
            ),
            heightSizedbox(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCounter(
                  width: appWidth(context) * 0.1,
                  bgColor: AppColors.whiteColorwithopacity,
                  widget: Icon(Icons.add),
                  iconcolor: AppColors.blackColor,
                ),
                CustomCounter(
                  width: appWidth(context) * 0.7,
                  bgColor: AppColors.whiteColorwithopacity,
                  widget: Text(
                    '1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  iconcolor: AppColors.blackColor,
                ),
                CustomCounter(
                  width: appWidth(context) * 0.1,
                  bgColor: AppColors.whiteColorwithopacity,
                  widget: Icon(Icons.remove),
                  iconcolor: AppColors.blackColor,
                ),
              ],
            ),
            heightSizedbox(10),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultElevatedButton(
          textbutton: "enter customer data",
          bgButtonColor: AppColors.blueColor,
          onPressed: () {},
          width: appWidth(context) * 0.87,
          textcolor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
