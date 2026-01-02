import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';

class CustomAppText extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const CustomAppText({
    Key? key,
    required this.text,
    this.textColor = Colors.black,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.end,
      maxLines: maxLines,
      softWrap: true,
      overflow: overflow ?? TextOverflow.visible,
      style: TextStyle(
        color: textColor ?? AppColor.blackColor,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
    );
  }
}
