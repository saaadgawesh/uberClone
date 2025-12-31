import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.actionIcon,
    required this.child,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.bgContainerColor,
    this.padding,
    this.borderwidth,
  });

  final IconData? actionIcon;
  final Widget child;
  final double height;
  final double width;
  final double? borderwidth;
  final Color bgContainerColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: borderwidth == null
            ? null
            : Border.all(width: borderwidth!, color: AppColor.greyColor),
        color: bgContainerColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
