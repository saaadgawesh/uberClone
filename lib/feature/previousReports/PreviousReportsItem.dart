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
              CustomAppText(
                text: tripNumber,
                textColor: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
              CustomAppText(
                text: "tripNumber",
                textColor: AppColors.blueColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomAppText(text: to, textColor: AppColors.blackColor),
              customAppIcon(
                iconName: Icons.arrow_back,
                iconColor: AppColors.blueColor,
              ),
              CustomAppText(text: from, textColor: AppColors.blackColor),
              customAppIcon(
                iconName: Icons.location_on,
                iconColor: AppColors.blueColor,
              ),
            ],
          ),
          AppDivider(),
          Row(
            children: [
              Row(
                children: [
                  HSpace(40),
                  CustomAppText(
                    text: "customer",
                    textColor: AppColors.blackColor,
                  ),
                  CustomAppText(text: "1", textColor: AppColors.blackColor),
                  customAppIcon(
                    iconName: Icons.group,
                    iconColor: AppColors.blueColor,
                  ),
                  HSpace(50),
                  CustomAppText(
                    text: "2025-11-8",
                    textColor: AppColors.blackColor,
                  ),
                  customAppIcon(
                    iconName: Icons.date_range,
                    iconColor: AppColors.blueColor,
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
