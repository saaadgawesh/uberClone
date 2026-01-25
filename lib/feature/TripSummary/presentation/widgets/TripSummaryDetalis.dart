import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

class TripSummaryDetalis extends StatelessWidget {
  const TripSummaryDetalis({super.key, required this.tripmodel});

  final Tripmodel tripmodel;

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;
    return CustomContainer(
      padding: const EdgeInsets.all(10),
      bgContainerColor: context.bgColor,
      height: appHeight(context) * 0.33,
      width: appWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// distance / duration / price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TripSummaryDetalisItem(
                distancetext: applocalization.km,
                title: tripmodel.distanceKm.toStringAsFixed(2),
              ),
              TripSummaryDetalisItem(
                distancetext: applocalization.min,
                title: tripmodel.durationMin.toStringAsFixed(1),
              ),
              TripSummaryDetalisItem(
                distancetext: applocalization.eGP,
                title: tripmodel.price.toStringAsFixed(2),
              ),
            ],
          ),

          const SizedBox(height: 8),
          AppDivider(color: AppColors.whiteColor),
          const SizedBox(height: 8),

          CustomAppText(
            text: applocalization.start,
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
          Expanded(
            child: Text(
              tripmodel.startAddress,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 2),
          AppDivider(color: AppColors.whiteColor),
          const SizedBox(height: 2),
          CustomAppText(
            text: applocalization.end,
            textColor: AppColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
          Expanded(
            child: Text(
              tripmodel.endAddress,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
