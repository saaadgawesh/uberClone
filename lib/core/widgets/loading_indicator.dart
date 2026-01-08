import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppColors.blueColor));
  }
}
