import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/CustomAppText.dart';
import 'package:uberCloneRider/core/resources/customAppIcon.dart';
import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
import 'package:uberCloneRider/core/widgets/CustomContainer.dart';

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
    this.iconColor,
    this.height,
    this.fontSize,
    required this.textcolor,
  });
  final String textbutton;
  final Color textcolor;
  final Color bgButtonColor;
  final Color? iconColor;
  final VoidCallback onPressed;
  final IconData? iconName;
  final double width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: padding,
      height: height ?? appHeight(context) * 0.07,
      width: width,

      borderRadius: BorderRadius.circular(15),
      bgContainerColor: bgButtonColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparent,
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomAppText(
              text: textbutton,
              textColor: textcolor,
              fontWeight: FontWeight.w500,
              fontSize: fontSize ?? 16,
            ),
            widthSizedbox(5),
            if (iconName != null && iconColor != null)
              customAppIcon(iconName: iconName!, iconColor: iconColor!),
          ],
        ),
      ),
    );
  }
}
