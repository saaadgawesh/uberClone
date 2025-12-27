import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/AppDivider.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/CustomContainer.dart';
import 'package:uber/core/widgets/defaultElevatedButton.dart';

class PreviousReportsItem extends StatelessWidget {
  const PreviousReportsItem({
    super.key,
    this.viewbutton,
    required this.width1,
    required this.width2,
    required this.tripNumber,
    required this.to,
    required this.from,
    required this.textbutton1,
    required this.textbutton2,
  });
  final VoidCallback? viewbutton;
  final double width1;
  final double width2;
  final String tripNumber;
  final String to;
  final String from;
  final String textbutton1;
  final String textbutton2;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      height: appHeight(context) * 0.255,
      width: appWidth(context) * 0.9,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: AppColor.greyColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customAppText(
                text: tripNumber,
                textColor: AppColor.blackColor,
                fontWeight: FontWeight.bold,
              ),
              customAppText(
                text: "tripNumber",
                textColor: AppColor.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customAppText(text: to, textColor: AppColor.blackColor),
              customAppIcon(AppColor.blueColor, Icons.arrow_back),
              customAppText(text: from, textColor: AppColor.blackColor),
              customAppIcon(AppColor.blueColor, Icons.location_on),
            ],
          ),
          AppDivider(),
          Row(
            children: [
              Row(
                children: [
                  widthSizedbox(40),
                  customAppText(
                    text: "customer",
                    textColor: AppColor.blackColor,
                  ),
                  customAppText(text: "1", textColor: AppColor.blackColor),
                  customAppIcon(AppColor.blueColor, Icons.group),
                  widthSizedbox(50),
                  customAppText(
                    text: "2025-11-8",
                    textColor: AppColor.blackColor,
                  ),
                  customAppIcon(AppColor.blueColor, Icons.date_range),
                ],
              ),
            ],
          ),
          heightSizedbox(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (viewbutton != null)
                defaultElevatedButton(
                  iconName: Icons.share,
                  iconColor: AppColor.whiteColor,
                  textbutton: textbutton1,
                  bgButtonColor: AppColor.blueColor,
                  onPressed: viewbutton!,
                  width: width1,
                  textcolor: AppColor.whiteColor,
                ),
              defaultElevatedButton(
                iconName: Icons.picture_as_pdf_sharp,
                textbutton: textbutton2,
                bgButtonColor: AppColor.blueColor,
                onPressed: () {},
                width: width2,
                iconColor: AppColor.whiteColor,
                textcolor: AppColor.whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
