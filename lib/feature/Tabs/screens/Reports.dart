import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/App_TextField.dart';
import 'package:uber/core/widgets/CustomCounter.dart';
import 'package:uber/core/widgets/DefaultAppBar.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'kashf Al rokab'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customAppText(
              text: "text",
              textColor: AppColor.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            Padding(
              padding: EdgeInsets.only(left: 250),
              child: customAppText(
                text: "text",
                textColor: AppColor.blueColor,

                fontWeight: FontWeight.w500,
              ),
            ),
            AppTextField(
              prefix: Icon(Icons.arrow_drop_down),
              readOnly: true,
              hintText: "choose city",
            ),
            heightSizedbox(10),
            Padding(
              padding: EdgeInsets.only(left: 250),
              child: customAppText(
                text: "text",
                textColor: AppColor.blueColor,

                fontWeight: FontWeight.w500,
              ),
            ),
            AppTextField(
              prefix: Icon(Icons.arrow_drop_down),
              readOnly: true,
              hintText: "choose city",
            ),
            heightSizedbox(10),
            Padding(
              padding: EdgeInsets.only(left: 170),
              child: customAppText(
                text: "custumer number",
                textColor: AppColor.blueColor,

                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCounter(
                  width: 35,
                  bgColor: AppColor.whiteColor.withOpacity(0.2),
                  widget: Icon(Icons.add),
                  iconcolor: AppColor.blackColor,
                ),
                CustomCounter(
                  width: 200,
                  bgColor: AppColor.whiteColor.withOpacity(0.2),
                  widget: Text(
                    '1',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  iconcolor: AppColor.blackColor,
                ),
                CustomCounter(
                  width: 35,
                  bgColor: AppColor.whiteColor.withOpacity(0.2),
                  widget: Icon(Icons.remove),
                  iconcolor: AppColor.blackColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
