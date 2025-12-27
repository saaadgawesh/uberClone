import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/CustomContainer.dart';

// ignore: camel_case_types
class defaultElevatedButton extends StatelessWidget {
  const defaultElevatedButton({
    super.key,
    required this.textbutton,
    required this.bgButtonColor,
    required this.onPressed,
    this.iconName,
    required this.width,
    this.padding,
  });
  final String textbutton;
  final Color bgButtonColor;
  final VoidCallback onPressed;
  final IconData? iconName;
  final double width;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: padding,
      height: 35,
      width: width,
      borderRadius: BorderRadius.circular(15),
      bgContainerColor: bgButtonColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.transparent,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customAppText(text: textbutton, textColor: AppColor.whiteColor),
            widthSizedbox(10),
            if (iconName != null) customAppIcon(AppColor.whiteColor, iconName!),
          ],
        ),
      ),
    );
  }
}
