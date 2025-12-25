import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/widgets/CustomContainer.dart';

class CustomCounter extends StatelessWidget {
  const CustomCounter({
    super.key,
    required this.width,
    required this.bgColor,
    required this.icon,
  });
  final double width;
  final Color bgColor;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: appHeight(context) * 0.08,
      width: width,
      borderRadius: BorderRadius.circular(10),
      bgContainerColor: bgColor,
      child: customAppIcon(AppColor.whiteColor, icon),
    );
  }
}
