import 'package:flutter/material.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/widgets/CustomContainer.dart';

class CustomCounter extends StatelessWidget {
  const CustomCounter({
    super.key,
    required this.width,
    required this.bgColor,
    required this.widget,
    required this.iconcolor,
  });
  final double width;
  final Color bgColor;
  final Color iconcolor;
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderwidth: 1,
      height: appHeight(context) * 0.08,
      width: width,
      borderRadius: BorderRadius.circular(10),
      bgContainerColor: bgColor,
      child: widget,
    );
  }
}
