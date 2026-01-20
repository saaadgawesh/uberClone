import "../../../../core/App_Imports/app_imports.dart";

Widget MyRequestItem(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: CustomAppText(text: value, textColor: AppColors.whiteColor),
        ),
        Text(
          ':$title ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.whiteColor,
          ),
        ),
      ],
    ),
  );
}
