import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/AppDivider.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/CustomAppText.dart';
import 'package:uberCloneRider/core/resources/customAppIcon.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/CustomContainer.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';

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
              CustomAppText(text: tripNumber, fontWeight: FontWeight.bold),
              CustomAppText(
                text: "tripNumber",
                textColor: AppColor.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          heightSizedbox(5),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomAppText(text: to, fontWeight: FontWeight.w600),
              widthSizedbox(5),
              customAppIcon(iconName: Icons.arrow_back),
              widthSizedbox(5),
              CustomAppText(text: from, fontWeight: FontWeight.w600),
              widthSizedbox(5),
              customAppIcon(iconName: Icons.location_on),
            ],
          ),
          heightSizedbox(5),
          AppDivider(),
          heightSizedbox(5),
          Row(
            children: [
              Row(
                children: [
                  widthSizedbox(40),
                  CustomAppText(text: "customer"),
                  CustomAppText(text: "1"),
                  customAppIcon(iconName: Icons.group),
                  widthSizedbox(50),
                  CustomAppText(text: "2025-11-8"),
                  customAppIcon(
                    iconName: Icons.date_range,
                    iconColor: AppColor.whiteColor,
                  ),
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
