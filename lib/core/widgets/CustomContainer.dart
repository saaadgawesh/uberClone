import 'package:flutter/material.dart';

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
  });

  final IconData? actionIcon;
  final Widget child;
  final double height;
  final double width;
  final Color bgContainerColor;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: bgContainerColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
