import 'package:flutter/material.dart';

Widget customAppIcon(
  Color iconColor,
  IconData iconName,
  double size,
  VoidCallback onpressed,
) {
  return IconButton(
    color: iconColor,
    onPressed: onpressed,
    icon: Icon(iconName, size: size),
  );
}
