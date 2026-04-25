import '../../../core/App_Imports/app_imports.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  String? riderId;

  @override
  void initState() {
    super.initState();
    riderId = FirebaseAuth.instance.currentUser?.uid;
    NotificationService().setUserRole(UserRole.rider);
    NotificationService().setUserCollection('Rider');
    NotificationService().init();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> riderTripsStream() {
    if (riderId == null) {
      return const Stream.empty();
    }

    return FirebaseFirestore.instance
        .collection('trips')
        .where('riderId', isEqualTo: riderId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    if (riderId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: DefaultAppBar(title: 'طلباتي'),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: riderTripsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: context.bgColor),
            );
          }

          if (snapshot.hasError) {
            return const Center(child: Text('حدث خطأ أثناء تحميل الطلبات'));
          }

          final docs = snapshot.data?.docs.toList() ?? [];
          docs.sort((a, b) {
            final aTime =
                (a.data()['createdAt'] as Timestamp?)?.millisecondsSinceEpoch ??
                0;
            final bTime =
                (b.data()['createdAt'] as Timestamp?)?.millisecondsSinceEpoch ??
                0;
            return bTime.compareTo(aTime);
          });

          if (docs.isEmpty) {
            return const Center(child: Text('لا توجد طلبات حتى الآن'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final tripDoc = docs[index];
              final trip = tripDoc.data();

              final normalizedTrip = Tripmodel.fromMap(trip);
              final status = normalizedTrip.status;
              final price = normalizedTrip.price;
              final driverIdFromTrip = normalizedTrip.driverId;
              final driverName =
                  (trip['driverName'] ?? driverIdFromTrip).toString();
              final fromLat = normalizedTrip.startLocation.latitude;
              final fromLng = normalizedTrip.startLocation.longitude;
              final toLat = normalizedTrip.endLocation.latitude;
              final toLng = normalizedTrip.endLocation.longitude;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.bgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyRequestItem(
                      'الحالة',
                      _statusLabel(status),
                      context,
                      appWidth(context),
                    ),
                    MyRequestItem(
                      'السعر',
                      '${price.toStringAsFixed(0)} جنيه',
                      context,
                      appWidth(context),
                    ),
                    if (driverIdFromTrip.isNotEmpty)
                      MyRequestItem(
                        'السائق',
                        driverName,
                        context,
                        appWidth(context),
                      ),
                    const SizedBox(height: 8),
                    defaultElevatedButton(
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
                      textcolor: context.bgColor,
                    ),
                    if (driverIdFromTrip.isNotEmpty &&
                        (status == 'accepted' || status == 'ongoing')) ...[
                      const SizedBox(height: 10),
                      defaultElevatedButton(
                        onPressed: () {
                          showDriverLocationDialog(context, driverIdFromTrip);
                        },
                        textbutton: 'عرض موقع السائق',
                        bgButtonColor: AppColors.whiteColor,
                        width: appWidth(context),
                        textcolor: context.bgColor,
                      ),
                    ],
                    if (status == 'accepted' || status == 'completed') ...[
                      const SizedBox(height: 10),
                      defaultElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.paymentmethods);
                        },
                        textbutton: 'الدفع ${price.toStringAsFixed(0)} جنيه',
                        bgButtonColor: Colors.red,
                        width: appWidth(context),
                        textcolor: Colors.white,
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

String _statusLabel(String status) {
  switch (status) {
    case 'accepted':
      return 'تم قبول الرحلة';
    case 'requested':
    case 'pending':
      return 'جارٍ البحث عن سائق';
    case 'ongoing':
      return 'الرحلة جارية';
    case 'completed':
      return 'تمت الرحلة';
    case 'no_driver':
      return 'لا يوجد سائق متاح';
    case 'rejected':
      return 'تم رفض الرحلة';
    default:
      return 'جارٍ البحث عن سائق';
  }
}
