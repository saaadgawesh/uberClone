import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

Widget MyRequestItem(String title, String value, BuildContext context,double width) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: CustomContainer(
      padding: EdgeInsetsDirectional.only(start: 10, end: 10),
      bgContainerColor: AppColors.whiteColor,
      height: appHeight(context) * 0.07,
      width:width?? appWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAppText(
            textColor: context.bgColor,
            fontWeight: FontWeight.bold,
            text: '$title: ',
          ),
          Expanded(
            child: CustomAppText(textColor: context.bgColor, text: value),
          ),
        ],
      ),
    ),
  );
}
