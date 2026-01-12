import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/AppDivider.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/resources/CustomAppText.dart';
import 'package:uberCloneDriver/core/resources/customAppIcon.dart';
import 'package:uberCloneDriver/core/widgets/CustomContainer.dart';
import 'package:uberCloneDriver/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneDriver/core/widgets/spacing.dart';

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
      bgContainerColor: AppColors.greyColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppText(text: tripNumber, fontWeight: FontWeight.bold),
              CustomAppText(
                text: "tripNumber",
                textColor: AppColors.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          VSpace(5),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomAppText(text: to, fontWeight: FontWeight.w600),
              HSpace(5),
              customAppIcon(iconName: Icons.arrow_back),
              HSpace(5),
              CustomAppText(text: from, fontWeight: FontWeight.w600),
              HSpace(5),
              customAppIcon(iconName: Icons.location_on),
            ],
          ),
          VSpace(5),
          AppDivider(),
          VSpace(5),
          Row(
            children: [
              Row(
                children: [
                  HSpace(40),
                  CustomAppText(text: "customer"),
                  CustomAppText(text: "1"),
                  customAppIcon(iconName: Icons.group),
                  HSpace(50),
                  CustomAppText(text: "2025-11-8"),
                  customAppIcon(
                    iconName: Icons.date_range,
                    iconColor: AppColors.whiteColor,
                  ),
                ],
              ),
            ],
          ),
          VSpace(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (viewbutton != null)
                defaultElevatedButton(
                  iconName: Icons.share,
                  iconColor: AppColors.whiteColor,
                  textbutton: textbutton1,
                  bgButtonColor: AppColors.blueColor,
                  onPressed: viewbutton!,
                  width: width1,
                  textcolor: AppColors.whiteColor,
                ),
              defaultElevatedButton(
                iconName: Icons.picture_as_pdf_sharp,
                textbutton: textbutton2,
                bgButtonColor: AppColors.blueColor,
                onPressed: () {},
                width: width2,
                iconColor: AppColors.whiteColor,
                textcolor: AppColors.whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
