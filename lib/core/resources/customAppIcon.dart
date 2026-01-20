import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';

class customAppIcon extends StatelessWidget {
  const customAppIcon({
    super.key,
    this.iconColor,
    required this.iconName,
    this.size,
  });
  final Color? iconColor;
  final IconData iconName;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Icon(
      iconName,
      color: iconColor ?? AppColors.blueColor,
      size: size ?? 20,
    );
  }
}
