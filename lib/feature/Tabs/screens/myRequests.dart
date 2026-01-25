import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/App_Imports/app_imports.dart' hide Marker;

class Myrequests extends StatefulWidget {
  const Myrequests({super.key});

  @override
  State<Myrequests> createState() => _MyrequestsState();
}

class _MyrequestsState extends State<Myrequests> {
  String? riderId;

  @override
  void initState() {
    super.initState();
    riderId = FirebaseAuth.instance.currentUser?.uid;
  }

  /// Stream الرحلات المقبولة
  Stream<QuerySnapshot> acceptedTripsStream() {
    return FirebaseFirestore.instance
        .collection('trips')
        .where('riderId', isEqualTo: riderId)
        .where('status', isEqualTo: 'accepted')
        .snapshots();
  }

  /// تتبع موقع السائق لايف
  Stream<LatLng> trackDriverLocation(String driverId) {
    return FirebaseFirestore.instance
        .collection('drivers')
        .doc(driverId)
        .snapshots()
        .map((doc) {
          if (!doc.exists) throw Exception('Driver not found');
          final data = doc.data()!;
          if (!data.containsKey('location')) {
            throw Exception('Location not found');
          }
          final geoPoint = data['location'] as GeoPoint;
          return LatLng(geoPoint.latitude, geoPoint.longitude);
        });
  }

  /// عرض خريطة موقع السائق في Dialog
  void showDriverLocationDialog(BuildContext context, String driverId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: double.infinity,
            height: 300,
            child: StreamBuilder<LatLng>(
              stream: trackDriverLocation(driverId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final driverLocation = snapshot.data!;

                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: driverLocation,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('driver'),
                      position: driverLocation,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue,
                      ),
                    ),
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settingprovider = Provider.of<SettingsProvider>(context);
    if (riderId == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: DefaultAppBar(title: 'الرحلات المقبولة'),
      body: StreamBuilder<QuerySnapshot>(
        stream: acceptedTripsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: context.bgColor),
            );
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
              final String riderIdFromTrip = trip['riderId'];

              // ✅ التعديل المهم
              final String driverIdFromTrip = trip['driverId'];

              return Card(
                color: context.bgColor,
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // MyRequestItem('رقم الرحلة', tripId),
                      // MyRequestItem('السعر', '$price جنيه'),
                      // MyRequestItem('من', '$fromLat , $fromLng'),
                      // MyRequestItem('إلى', '$toLat , $toLng'),
                      MyRequestItem('الحالة', trip['status'], context),
                      const SizedBox(height: 10),
                      defaultElevatedButton(
                        onPressed: () {
                          showDriverLocationDialog(context, driverIdFromTrip);
                        },
                        textbutton: 'عرض موقع السائق',
                        bgButtonColor: settingprovider.isDark
                            ? AppColors.blueColor
                            : AppColors.blackColor,
                        width: appWidth(context),
                        textcolor: AppColors.whiteColor,
                      ),

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
                              textbutton: 'عرض رحلتك',
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
                                  riderId: riderIdFromTrip,
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
