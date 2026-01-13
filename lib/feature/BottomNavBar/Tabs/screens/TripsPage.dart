import '../../../../core/App_Imports/app_imports.dart';

class TripsPage extends StatelessWidget {
  const TripsPage({super.key});

  String get currentDriverId => FirebaseAuth.instance.currentUser!.uid;

  Stream<QuerySnapshot> acceptedTripsStream() {
    return FirebaseFirestore.instance
        .collection('trips')
        .where('driverId', isEqualTo: currentDriverId)
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

              return Card(
                color: AppColors.blueColor,
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _row('رقم الرحلة', trip['tripId']),
                      _row('السعر', '${trip['price']} جنيه'),
                      _row('من', '${trip['fromLat']}, ${trip['fromLng']}'),
                      _row('إلى', '${trip['toLat']}, ${trip['toLng']}'),
                      _row('الحالة', trip['status']),
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

  Widget _row(String title, String value) {
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
}
