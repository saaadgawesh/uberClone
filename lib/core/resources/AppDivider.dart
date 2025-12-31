import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: 20,
      endIndent: 20,
      color: AppColor.blueColor,
      height: 0.1,
    );
  }
}
