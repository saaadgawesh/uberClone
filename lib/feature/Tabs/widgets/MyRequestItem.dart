import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

Widget MyRequestItem(String title, String value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: CustomContainer(
      padding: EdgeInsetsDirectional.only(start: 10, end: 10),
      bgContainerColor: AppColors.error,
      height: appHeight(context) * 0.07,
      width: appWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppText(
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            text: '$title: ',
          ),
          Expanded(
            child: CustomAppText(textColor: AppColors.whiteColor, text: value),
          ),
        ],
      ),
    ),
  );
}
