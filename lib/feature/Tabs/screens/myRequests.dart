// import '../../../core/App_Imports/app_imports.dart';

// class MyRequests extends StatefulWidget {
//   const MyRequests({super.key});

//   @override
//   State<MyRequests> createState() => _MyRequestsState();
// }

// class _MyRequestsState extends State<MyRequests> {
//   String? riderId;
//   late Box<TripsModel> tripsBox;

//   @override
//   void initState() {
//     super.initState();
//     riderId = FirebaseAuth.instance.currentUser?.uid;
//     tripsBox = Hive.box<TripsModel>('tripsBox');

//     if (riderId != null) {
//       // حفظ الـ FCM token في Firestore
//       FirebaseMessaging.instance.getToken().then((token) {
//         if (token != null) {
//           FirebaseFirestore.instance.collection('Riders').doc(riderId).update({
//             'riderToken': token,
//           });
//         }
//       });
//     }

//     // تهيئة NotificationService
//     NotificationService().setUserRole(UserRole.rider);
//     NotificationService().init();

//     // استقبال الإشعارات أثناء foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       final type = message.data['type'] ?? '';
//       final tripId = message.data['tripId'] ?? '';
//       String body = '';

//       if (type == 'trip_accepted') {
//         body = 'السائق وافق على الرحلة 🚗';
//       } else if (type == 'driver_rejected') {
//         body = 'السائق رفض الرحلة، جاري البحث عن سائق آخر 🚗';
//       }

//       if (body.isNotEmpty) {
//         NotificationService().showNotification(
//           title: 'رحلتك',
//           body: body,
//           payload: tripId,
//         );

//         if (mounted) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(body)));
//         }
//       }
//     });

//     // استقبال الاشعارات عند فتح التطبيق من notification
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       final tripId = message.data['tripId'] ?? '';
//       if (tripId.isNotEmpty) {
//         NotificationService().handleNavigation(tripId);
//       }
//     });
//   }

//   /// Stream الرحلات المقبولة من Firestore
//   Stream<QuerySnapshot> acceptedTripsStream() {
//     return FirebaseFirestore.instance
//         .collection('trips')
//         .where('riderId', isEqualTo: riderId)
//         .where('status', isEqualTo: 'accepted')
//         .snapshots();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (riderId == null) {
//       return const Scaffold(body: Center(child: CircularProgressIndicator()));
//     }

//     return Scaffold(
//       appBar: DefaultAppBar(title: 'الرحلات المقبولة'),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: acceptedTripsStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(color: context.bgColor),
//             );
//           }

//           if (snapshot.hasError) {
//             return const Center(child: Text('حدث خطأ أثناء تحميل البيانات'));
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text('لا توجد رحلات مقبولة حالياً'));
//           }

//           /// فلترة الرحلات اللي اتعملها حذف أو completed من Hive
//           final trips = snapshot.data!.docs.where((doc) {
//             return !tripsBox.containsKey(doc.id);
//           }).toList();

//           if (trips.isEmpty) {
//             return const Center(child: Text('لا توجد رحلات حالياً'));
//           }

//           return ListView.builder(
//             itemCount: trips.length,
//             itemBuilder: (context, index) {
//               final tripDoc = trips[index];
//               final trip = tripDoc.data() as Map<String, dynamic>;

//               final double fromLat = (trip['fromLat'] as num).toDouble();
//               final double fromLng = (trip['fromLng'] as num).toDouble();
//               final double toLat = (trip['toLat'] as num).toDouble();
//               final double toLng = (trip['toLng'] as num).toDouble();
//               final double price = (trip['price'] as num).toDouble();
//               final String driverIdFromTrip = trip['driverId'];

//               return Dismissible(
//                 key: ValueKey(tripDoc.id),
//                 background: Container(
//                   color: Colors.green,
//                   alignment: Alignment.centerLeft,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: const Icon(Icons.check, color: Colors.white),
//                 ),
//                 secondaryBackground: Container(
//                   color: Colors.red,
//                   alignment: Alignment.centerRight,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: const Icon(Icons.delete, color: Colors.white),
//                 ),
//                 confirmDismiss: (direction) async {
//                   if (direction == DismissDirection.startToEnd) {
//                     tripsBox.put(
//                       tripDoc.id,
//                       TripsModel(
//                         tripId: tripDoc.id,
//                         status: 'completed',
//                         actionDate: DateTime.now(),
//                       ),
//                     );
//                   } else {
//                     tripsBox.put(
//                       tripDoc.id,
//                       TripsModel(
//                         tripId: tripDoc.id,
//                         status: 'deleted',
//                         actionDate: DateTime.now(),
//                       ),
//                     );
//                   }
//                   return true;
//                 },
//                 child: Card(
//                   color: context.bgColor,
//                   margin: const EdgeInsets.all(12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         customAppIcon(
//                           iconName: Icons.arrow_back_ios,
//                           iconColor: AppColors.greenColor,
//                         ),
//                         AppDivider(
//                           height: appHeight(context) * 0.2,
//                           indent: 1,
//                           endindent: 2,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             MyRequestItem(
//                               'الحالة',
//                               trip['status'],
//                               context,
//                               appWidth(context) * 0.65,
//                             ),
//                             const SizedBox(height: 10),
//                             defaultElevatedButton(
//                               onPressed: () {
//                                 showDriverLocationDialog(
//                                   context,
//                                   driverIdFromTrip,
//                                 );
//                               },
//                               textbutton: 'عرض موقع السائق',
//                               bgButtonColor: AppColors.whiteColor,
//                               width: appWidth(context) * 0.65,
//                               textcolor: context.bgColor,
//                             ),
//                             const SizedBox(height: 10),
//                             defaultElevatedButton(
//                               onPressed: () {
//                                 openRouteInGoogleMaps(
//                                   fromLat: fromLat,
//                                   fromLng: fromLng,
//                                   toLat: toLat,
//                                   toLng: toLng,
//                                 );
//                               },
//                               textbutton: 'عرض رحلتك',
//                               bgButtonColor: AppColors.whiteColor,
//                               width: appWidth(context) * 0.65,
//                               textcolor: context.bgColor,
//                             ),
//                             const SizedBox(height: 10),
//                             defaultElevatedButton(
//                               onPressed: () {
//                                 Navigator.pushNamed(
//                                   context,
//                                   Routes.paymentmethods,
//                                 );
//                               },
//                               textbutton: 'دفع ${price.toInt()} جنيه',
//                               bgButtonColor: Colors.red,
//                               width: appWidth(context) * 0.65,
//                               textcolor: Colors.white,
//                             ),
//                           ],
//                         ),
//                         AppDivider(
//                           height: appHeight(context) * 0.2,
//                           indent: 0,
//                           endindent: 0,
//                         ),
//                         customAppIcon(
//                           iconName: Icons.arrow_forward_ios,
//                           iconColor: AppColors.redColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//================================================================================================

import '../../../core/App_Imports/app_imports.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  String? riderId;
  late Box<TripsModel> tripsBox;

  @override
  void initState() {
    super.initState();
    riderId = FirebaseAuth.instance.currentUser?.uid;
    tripsBox = Hive.box<TripsModel>('tripsBox');

    // تهيئة NotificationService
    NotificationService().setUserRole(UserRole.rider);
    NotificationService().init();
  }

  /// Stream الرحلات المقبولة من Firestore
  Stream<QuerySnapshot> acceptedTripsStream() {
    return FirebaseFirestore.instance
        .collection('trips')
        .where('riderId', isEqualTo: riderId)
        .where('status', isEqualTo: 'accepted')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
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

          /// فلترة الرحلات اللي اتعملها حذف أو completed من Hive
          final trips = snapshot.data!.docs.where((doc) {
            return !tripsBox.containsKey(doc.id);
          }).toList();

          if (trips.isEmpty) {
            return const Center(child: Text('لا توجد رحلات حالياً'));
          }

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final tripDoc = trips[index];
              final trip = tripDoc.data() as Map<String, dynamic>;

              final double fromLat = (trip['fromLat'] as num).toDouble();
              final double fromLng = (trip['fromLng'] as num).toDouble();
              final double toLat = (trip['toLat'] as num).toDouble();
              final double toLng = (trip['toLng'] as num).toDouble();
              final double price = (trip['price'] as num).toDouble();
              final String driverIdFromTrip = trip['driverId'];

              return Dismissible(
                key: ValueKey(tripDoc.id),

                /// سحب يمين = رحلة ناجحة
                background: Container(
                  color: Colors.green,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.check, color: Colors.white),
                ),

                /// سحب شمال = حذف
                secondaryBackground: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                confirmDismiss: (direction) async {
                  if (direction == DismissDirection.startToEnd) {
                    /// تثبيت كرحلة ناجحة
                    tripsBox.put(
                      tripDoc.id,
                      TripsModel(
                        tripId: tripDoc.id,
                        status: 'completed',
                        actionDate: DateTime.now(),
                      ),
                    );
                  } else {
                    /// حذف محلي
                    tripsBox.put(
                      tripDoc.id,
                      TripsModel(
                        tripId: tripDoc.id,
                        status: 'deleted',
                        actionDate: DateTime.now(),
                      ),
                    );
                  }
                  return true;
                },
                child: Card(
                  color: context.bgColor,
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customAppIcon(
                          iconName: Icons.arrow_back_ios,
                          iconColor: AppColors.greenColor,
                        ),
                        AppDivider(
                          height: appHeight(context) * 0.2,
                          indent: 1,
                          endindent: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyRequestItem(
                              'الحالة',
                              trip['status'],
                              context,
                              appWidth(context) * 0.65,
                            ),
                            const SizedBox(height: 10),
                            defaultElevatedButton(
                              onPressed: () {
                                showDriverLocationDialog(
                                  context,
                                  driverIdFromTrip,
                                );
                              },
                              textbutton: 'عرض موقع السائق',
                              bgButtonColor: AppColors.whiteColor,
                              width: appWidth(context) * 0.65,
                              textcolor: context.bgColor,
                            ),
                            const SizedBox(height: 10),
                            defaultElevatedButton(
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
                              width: appWidth(context) * 0.65,
                              textcolor: context.bgColor,
                            ),
                            const SizedBox(height: 10),
                            defaultElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.paymentmethods,
                                );
                              },
                              textbutton: 'دفع ${price.toInt()} جنيه',
                              bgButtonColor: Colors.red,
                              width: appWidth(context) * 0.65,
                              textcolor: Colors.white,
                            ),
                          ],
                        ),
                        AppDivider(
                          height: appHeight(context) * 0.2,
                          indent: 0,
                          endindent: 0,
                        ),
                        customAppIcon(
                          iconName: Icons.arrow_forward_ios,
                          iconColor: AppColors.redColor,
                        ),
                      ],
                    ),
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
