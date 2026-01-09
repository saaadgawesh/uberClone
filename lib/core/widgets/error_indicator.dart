import 'package:flutter/material.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/widgets/defaultElevatedButton.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;

  // ignore: use_key_in_widget_constructors
  const ErrorIndicator([this.message = 'Something went wrong!']);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: defaultElevatedButton(
        textbutton: message,
        bgButtonColor: AppColors.error,
        onPressed: () {
          Navigator.pop(context);
        },
        width: appWidth(context),
        textcolor: AppColors.whiteColor,
      ),
    );
  }
}
