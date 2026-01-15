import '../../../core/App_Imports/app_imports.dart';

class Myrequests extends StatelessWidget {
  const Myrequests({super.key});

  String get currentRiderId => FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot> acceptedTripsStream() {
    return FirebaseFirestore.instance
        .collection('trips')
        .where('riderId', isEqualTo: currentRiderId)
        .where('status', isEqualTo: 'accepted')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'الرحلات المقبولة'),
      body: StreamBuilder<QuerySnapshot>(
        stream: acceptedTripsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('لا توجد رحلات مقبولة حالياً'));
          }

          final trips = snapshot.data!.docs;

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index].data() as Map<String, dynamic>;

              final double fromLat = (trip['fromLat'] as num).toDouble();
              final double fromLng = (trip['fromLng'] as num).toDouble();
              final double toLat = (trip['toLat'] as num).toDouble();
              final double toLng = (trip['toLng'] as num).toDouble();

              final double price = (trip['price'] as num).toDouble();
              final String tripId = trip['tripId'];
              final String riderId = trip['riderId'];
              // final String driverId = trip['driverId'];

              return Card(
                color: AppColors.blueColor,
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyRequestItem('رقم الرحلة', tripId),
                      MyRequestItem('السعر', '$price جنيه'),
                      MyRequestItem('من', '$fromLat , $fromLng'),
                      MyRequestItem('إلى', '$toLat , $toLng'),
                      MyRequestItem('الحالة', trip['status']),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: defaultElevatedButton(
                              onPressed: () {
                                openRouteInGoogleMaps(
                                  fromLat: fromLat,
                                  fromLng: fromLng,
                                  toLat: toLat,
                                  toLng: toLng,
                                );
                              },
                              textbutton: 'عرض الرحلة',
                              bgButtonColor: AppColors.whiteColor,
                              width: appWidth(context),
                              textcolor: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: defaultElevatedButton(
                              onPressed: () async {
                                final paymobManager = Paymentmanager();
                                await paymobManager.payForTripWithPaymob(
                                  tripId: tripId,
                                  riderId: riderId,
                                  amount: price,
                                );
                              },
                              textbutton: 'دفع ${price.toInt()} جنيه',
                              bgButtonColor: Colors.green,
                              width: appWidth(context),
                              textcolor: Colors.white,
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
