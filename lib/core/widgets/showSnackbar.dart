import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
  BuildContext context,
  String title,
  Color bgsnackbar,
) {
  return ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(backgroundColor: bgsnackbar, content: Text(title)));
}
