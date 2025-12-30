import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/CustomContainer.dart';
import 'package:uber/core/widgets/defaultElevatedButton.dart';

class ChooseYourBussinessitem extends StatelessWidget {
  const ChooseYourBussinessitem({
    super.key,
    required this.backGroundColor,
    required this.title,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.textbutton,
    required this.bgButtonColor,
    this.icon,
    this.iconcolor,
    this.bgIconColor,
    required this.onpressed,
    this.widthElevatedButton,
  });
  final Color backGroundColor;
  final Color bgButtonColor;
  final Color? iconcolor;
  final Color? bgIconColor;
  final String title;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String textbutton;
  final IconData? icon;
  final double? widthElevatedButton;
  final VoidCallback onpressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: CustomContainer(
        padding: EdgeInsets.all(15),
        height: appHeight(context) * 0.37,
        width: appWidth(context) * 0.9,
        borderRadius: BorderRadius.circular(15),
        bgContainerColor: backGroundColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,

                  children: [
                    customAppText(
                      text: title,
                      textColor: AppColor.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    heightSizedbox(8),
                    customAppText(
                      text: text1,
                      // ignore: deprecated_member_use
                      textColor: AppColor.blackColorwithopacity,
                    ),
                    heightSizedbox(8),
                    customAppText(text: text2, textColor: AppColor.blackColor),
                    heightSizedbox(8),
                    customAppText(text: text3, textColor: AppColor.blackColor),
                    heightSizedbox(8),
                    customAppText(text: text4, textColor: AppColor.blackColor),
                  ],
                ),
                widthSizedbox(10),

                if (icon != null && iconcolor != null)
                  CustomContainer(
                    height: 50,
                    width: 40,
                    borderRadius: BorderRadius.circular(10),
                    bgContainerColor: bgIconColor!,
                    child: customAppIcon(iconcolor!, icon!, 20),
                  ),
              ],
            ),
            Spacer(),
            if (widthElevatedButton != null)
              defaultElevatedButton(
                textbutton: textbutton,
                bgButtonColor: bgButtonColor,
                onPressed: onpressed,
                width: widthElevatedButton!,
                textcolor: AppColor.whiteColor,
              ),
          ],
        ),
      ),
    );
  }
}
