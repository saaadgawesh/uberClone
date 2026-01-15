import "../Imports/app_imports.dart";

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
  BuildContext context,
  String title,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.redColor,
      content: CustomAppText(
        text: title,
        textAlign: TextAlign.center,
        textColor: AppColors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
