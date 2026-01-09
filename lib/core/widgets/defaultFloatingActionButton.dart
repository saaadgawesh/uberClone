import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/widgets/CustomContainer.dart';

class defaultFloatingActionButton extends StatelessWidget {
  const defaultFloatingActionButton({
    super.key,
    this.backgroundColor,
    this.iconColor,
    this.iconName,
    this.onpressed,
    this.size,
  });
  final Color? backgroundColor;
  final Color? iconColor;
  final IconData? iconName;
  final VoidCallback? onpressed;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: appHeight(context) * 0.097,
      width: appWidth(context) * 0.14,
      child: FloatingActionButton(
        backgroundColor: backgroundColor ?? AppColors.blueColor,
        onPressed: onpressed,
        child: Icon(
          iconName ?? Icons.my_location,
          color: iconColor ?? AppColors.whiteColor,
          size: size ?? 18,
        ),
      ),
    );
  }
}
