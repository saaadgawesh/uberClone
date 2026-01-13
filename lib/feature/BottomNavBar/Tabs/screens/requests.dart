import '../../../../core/App_Imports/app_imports.dart';
class Requests extends StatelessWidget {
  final DriverRepository driverRepo = DriverRepository();
  Requests({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'طلباتك',
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: driverRepo.getDriverTrips(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('لا توجد طلبات جديدة'));
          }

          final trips = snapshot.data!.docs;

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index].data();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomContainer(
                  padding: EdgeInsets.all(10),
                  height: appHeight(context) * 0.3249,
                  width: appWidth(context),
                  bgContainerColor: AppColors.blueColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomAppText(
                                text: 'price: ${' السعر: ${trip['price']}'}',
                                textColor: AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      VSpace(15),
                      AppDivider(color: AppColors.whiteColor),
                      VSpace(10),

                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.red),
                            SizedBox(width: 8),
                            CustomAppText(
                              text: "Open Route in Maps",
                              textColor: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),

                      VSpace(15),
                      AppDivider(color: AppColors.whiteColor),
                      VSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              acceptTrip(trips[index].id);

                              context.pushNamed(Routes.TripsPage);
                            },
                            child: CustomContainer(
                              bgContainerColor: AppColors.greenColor,
                              height: appHeight(context) * 0.07,
                              width: appWidth(context) * 0.4,
                              child: CustomAppText(
                                text: "Accepted",
                                textColor: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              rejectTrip(trips[index].id);
                            },
                            child: CustomContainer(
                              bgContainerColor: AppColors.redColor,
                              height: appHeight(context) * 0.07,
                              width: appWidth(context) * 0.4,
                              child: CustomAppText(
                                text: "Rejected",
                                textColor: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
