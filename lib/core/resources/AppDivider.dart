import 'package:flutter/material.dart';
import 'package:uber/core/constant/App_Color.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(indent: 10, endIndent: 10, color: AppColor.blueColor);
  }
}
