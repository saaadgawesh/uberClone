import 'package:flutter/material.dart';

// ignore: camel_case_types
class customAppText extends StatelessWidget {
  const customAppText({
    super.key,
    required this.text,
    required this.textColor,
    this.fontSize,
    this.fontWeight, this.maxLines, this.overflow,
  });
  final String text;
  final Color textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,maxLines: maxLines,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),overflow: overflow,
    );
  }
}

//   overflow:,
