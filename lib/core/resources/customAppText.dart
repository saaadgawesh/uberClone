import 'package:flutter/material.dart';

class customAppText extends StatelessWidget {
  const customAppText({
    super.key,
    required this.text,
    required this.textColor,
    this.fontSize,
    this.fontWeight,
  });
  final String text;
  final Color textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
