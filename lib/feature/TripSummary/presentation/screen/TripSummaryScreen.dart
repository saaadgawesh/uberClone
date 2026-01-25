import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

class TripSummaryScreen extends StatelessWidget {
  final Tripmodel tripmodel;

  const TripSummaryScreen({super.key, required this.tripmodel});

  @override
  Widget build(BuildContext context) {
    final applocalization=AppLocalizations.of(context)!;
    return Scaffold(
      appBar: DefaultAppBar(
        title: applocalization.tripSummary,
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                Assets.car1,
                width: appWidth(context),
                height: appHeight(context) * 0.24,
                fit: BoxFit.cover,
              ),
            ),
            heightSizedbox(5),
            const TripSummarytitleSection(),
            heightSizedbox(5),

            /// 👇 مصدر البيانات واحد
            TripSummaryDetalis(tripmodel: tripmodel),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0),
        child: defaultElevatedButton(
          height: appHeight(context) * 0.09,
          textbutton: applocalization.createTrip,
          bgButtonColor: context.bgColor,
          width: appWidth(context),
          textcolor: AppColors.whiteColor,
          onPressed: () async {
            Navigator.pushReplacementNamed(
              context,
              Routes.SearchingForDriverScreen,
              arguments: tripmodel,
            );
          },
        ),
      ),
    );
  }
}
