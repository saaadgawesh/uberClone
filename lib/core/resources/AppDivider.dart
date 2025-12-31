import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.indent, this.endindent, this.color});
  final double? indent;
  final double? endindent;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: indent ?? 20,
      endIndent: endindent ?? 20,
      color: color ?? AppColor.blueColor,
      height: 0.1,
    );
  }
}
