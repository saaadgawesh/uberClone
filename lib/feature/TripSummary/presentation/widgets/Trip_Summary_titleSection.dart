import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

class TripSummarytitleSection extends StatelessWidget {
  const TripSummarytitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    final applocalization=AppLocalizations.of(context)!;
    return CustomContainer(
      padding: EdgeInsets.all(10),
      bgContainerColor: context.bgColor,
      height: appHeight(context) * 0.09,
      width: appWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomAppText(
            text:applocalization.distance ,
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          CustomAppText(
            text: applocalization.duration,
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
          CustomAppText(
            text:applocalization.price,
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
