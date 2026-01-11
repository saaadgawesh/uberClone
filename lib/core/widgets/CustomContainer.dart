import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.actionIcon,

    required this.height,
    required this.width,
    this.borderRadius,
    this.bgContainerColor,
    this.padding,
    this.borderwidth,
    required this.child,
  });

  final IconData? actionIcon;

  final double height;
  final double width;
  final double? borderwidth;
  final Color? bgContainerColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget child;

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
            : Border.all(width: borderwidth!, color: AppColors.greyColor),
        color: bgContainerColor,
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
