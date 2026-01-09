import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/constant/assets.dart';
import 'package:uberCloneDriver/core/resources/AppTextStyles.dart';
import 'package:uberCloneDriver/core/widgets/appbutton.dart';
import 'package:uberCloneDriver/core/widgets/spacing.dart';

void showCancelDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          height: 475.h,
          width: 341.w,
          padding: const EdgeInsets.only(
            top: 32,
            bottom: 32,
            left: 48,
            right: 48,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(48),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Assets.car1, width: 131.w, height: 131.h),
              HSpace(32),
              Text(
                'Warning!',
                style: AppTextStyles.georgiaSubheading.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.warning,
                ),
              ),
              HSpace(32),
              Text(
                'Cancellation must be made at least\n 24 hours in advance to receive a\n refund!',
                textAlign: TextAlign.center,
                style: AppTextStyles.georgiaCaption.copyWith(
                  color: AppColors.secondary300,
                ),
              ),
              HSpace(35),
              Text(
                'Are you sure?',
                textAlign: TextAlign.center,
                style: AppTextStyles.georgiaCaption.copyWith(
                  color: AppColors.secondary300,
                ),
              ),

              HSpace(13),
              AppButton(
                text: 'Yes, Cancel',
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.black,
                width: 245.w,
                height: 45.h,
                borderRadius: 50.r,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
