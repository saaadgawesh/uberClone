import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.text,
    required this.creditName,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final String creditName;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.all(2.h),
        height: 56.h,
        width: 396.w,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.success50 : context.bgColor,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: AppColors.grey50),
        ),
        child: Row(
          children: [
            SizedBox(width: 10.w),
            Image.asset(
              isSelected ? Assets.checksolid : Assets.checkempty,
              width: 24.w,
              height: 24.h,
              color: isSelected ? AppColors.success : AppColors.whiteColor,
            ),
            SizedBox(width: 5.w),
            Text(
              text,
              style: AppTextStyles.montserratButton.copyWith(
                color: isSelected ? AppColors.success : AppColors.whiteColor,
              ),
            ),
            const Spacer(),
            Image.asset(
              creditName,
              color: isSelected ? AppColors.success : AppColors.whiteColor,
            ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}
