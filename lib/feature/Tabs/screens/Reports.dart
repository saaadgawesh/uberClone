import 'package:flutter/material.dart';
import 'package:uberCloneCustomer/core/constant/App_Color.dart';
import 'package:uberCloneCustomer/core/resources/App_Size.dart';
import 'package:uberCloneCustomer/core/resources/customAppText.dart';
import 'package:uberCloneCustomer/core/resources/sizedboxWidget.dart';
import 'package:uberCloneCustomer/core/widgets/CustomCounter.dart';
import 'package:uberCloneCustomer/core/widgets/DefaultAppBar.dart';
import 'package:uberCloneCustomer/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneCustomer/feature/Tabs/widgets/textfieldWithSectionTitle.dart';

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
            customAppText(
              text: "text",
              textColor: AppColor.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            Textfieldwithsectiontitle(text: 'from', hinttext: 'choose city'),
            heightSizedbox(10),
            Textfieldwithsectiontitle(text: 'to', hinttext: 'choose city'),
            heightSizedbox(10),
            customAppText(
              text: "custumer number",
              textColor: AppColor.blueColor,

              fontWeight: FontWeight.w500,
            ),
            heightSizedbox(5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCounter(
                  width: appWidth(context) * 0.1,
                  bgColor: AppColor.whiteColorwithopacity,
                  widget: Icon(Icons.add),
                  iconcolor: AppColor.blackColor,
                ),
                CustomCounter(
                  width: appWidth(context) * 0.7,
                  bgColor: AppColor.whiteColorwithopacity,
                  widget: Text(
                    '1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  iconcolor: AppColor.blackColor,
                ),
                CustomCounter(
                  width: appWidth(context) * 0.1,
                  bgColor: AppColor.whiteColorwithopacity,
                  widget: Icon(Icons.remove),
                  iconcolor: AppColor.blackColor,
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
          bgButtonColor: AppColor.blueColor,
          onPressed: () {},
          width: appWidth(context) * 0.87,
          textcolor: AppColor.whiteColor,
        ),
      ),
    );
  }
}
