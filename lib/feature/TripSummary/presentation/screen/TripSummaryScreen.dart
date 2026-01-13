import 'package:uberCloneRider/core/App_Imports/app_imports.dart';




class TripSummaryScreen extends StatelessWidget {
  final TripData tripData;

  const TripSummaryScreen({super.key, required this.tripData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Trip Summary",
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
            TripSummaryDetalis(tripData: tripData),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5.0),
        child: defaultElevatedButton(
          height: appHeight(context) * 0.09,
          textbutton: 'Create Trip',
          bgButtonColor: AppColors.blueColor,
          width: appWidth(context),
          textcolor: AppColors.whiteColor,
          onPressed: () async {

            Navigator.pushReplacementNamed(
              context,
              Routes.SearchingForDriverScreen,
              arguments: tripData,
            );
          },
        ),
      ),
    );
  }
}
