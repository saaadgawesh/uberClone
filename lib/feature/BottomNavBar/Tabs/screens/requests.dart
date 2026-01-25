import 'package:http/http.dart' as http;

import '../../../../core/App_Imports/app_imports.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final DriverRepository driverRepo = DriverRepository();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> trips = [];

  @override
  void initState() {
    super.initState();

    // تحديد دور المستخدم في NotificationService
    NotificationService().setUserRole(UserRole.driver);

    // الاستماع لكل الرحلات الخاصة بالسواق الحالي
    final currentDriverId = FirebaseAuth.instance.currentUser!.uid;
    NotificationService().listenToDriverTrips(currentDriverId);
  }

  /// دالة إرسال إشعار FCM
  Future<void> sendPushToUser({
    required String token,
    required String title,
    required String body,
  }) async {
    const serverKey = 'YOUR_FIREBASE_SERVER_KEY'; // ضع هنا المفتاح الخاص بك

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode({
        "to": token,
        "notification": {"title": title, "body": body},
        "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK"},
      }),
    );
  }

  /// قبول الرحلة
  Future<void> acceptTrip(String tripId) async {
    final driverId = FirebaseAuth.instance.currentUser!.uid;
    final tripRef = FirebaseFirestore.instance.collection('trips').doc(tripId);

    final tripSnap = await tripRef.get();
    final trip = tripSnap.data()!;
    final riderId = trip['riderId'];

    // تحديث الرحلة
    await tripRef.update({'status': 'accepted', 'driverId': driverId});

    // تحديث حالة السائق
    await FirebaseFirestore.instance.collection('Driver').doc(driverId).update({
      'status': 'busy',
    });

    // إشعار الراكب
    final riderDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(riderId)
        .get();
    final token = riderDoc['fcmToken'];

    await sendPushToUser(
      token: token,
      title: 'تم قبول الرحلة',
      body: 'السائق في الطريق إليك 🚗',
    );
  }

  /// رفض الرحلة وتحويلها للسائق التالي
  Future<void> rejectTrip(String tripId) async {
    final driverId = FirebaseAuth.instance.currentUser!.uid;
    final tripRef = FirebaseFirestore.instance.collection('trips').doc(tripId);
    final tripSnap = await tripRef.get();

    if (!tripSnap.exists) return;

    final trip = tripSnap.data()!;
    final riderId = trip['riderId'];

    List<String> rejectedDrivers = List<String>.from(
      trip['rejectedDrivers'] ?? [],
    );
    rejectedDrivers.add(driverId);

    // البحث عن سائق جديد متاح
    final nextDriverQuery = await FirebaseFirestore.instance
        .collection('Driver')
        .where('status', isEqualTo: 'available')
        .get();

    String? nextDriverId;

    for (var doc in nextDriverQuery.docs) {
      if (!rejectedDrivers.contains(doc.id)) {
        nextDriverId = doc.id;
        break;
      }
    }

    if (nextDriverId == null) {
      // لا يوجد سائقين متاحين
      await tripRef.update({
        'status': 'no_driver',
        'rejectedDrivers': rejectedDrivers,
      });

      // إشعار الراكب بعدم وجود سائق
      final riderDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(riderId)
          .get();
      final riderToken = riderDoc['fcmToken'];

      await sendPushToUser(
        token: riderToken,
        title: 'تم رفض الرحلة',
        body: 'لا يوجد سائق متاح حاليا 🚫',
      );
      return;
    }

    // تحديث الرحلة للسائق الجديد
    await tripRef.update({
      'status': 'waiting_driver',
      'driverId': nextDriverId,
      'rejectedDrivers': rejectedDrivers,
    });

    // إشعار الراكب
    final riderDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(riderId)
        .get();
    final riderToken = riderDoc['fcmToken'];

    await sendPushToUser(
      token: riderToken,
      title: 'جاري البحث عن سائق آخر',
      body: 'تم رفض الرحلة من السائق السابق، جاري تحويلها لسائق آخر',
    );

    // إشعار السائق الجديد
    final newDriverDoc = await FirebaseFirestore.instance
        .collection('Driver')
        .doc(nextDriverId)
        .get();
    final newDriverToken = newDriverDoc['fcmToken'];

    await sendPushToUser(
      token: newDriverToken,
      title: 'رحلة جديدة',
      body: 'لديك طلب رحلة جديد 🚕',
    );
  }

  @override
  Widget build(BuildContext context) {
    final driverId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'طلباتك',
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: driverRepo.getDriverTrips(driverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: CustomAppText(
                text: 'لا توجد طلبات جديدة',
                textColor: context.bgColor,
              ),
            );
          }

          trips = snapshot.data!.docs;

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              final trip = trips[index].data();

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomContainer(
                  padding: const EdgeInsets.all(10),
                  height: appHeight(context) * 0.3249,
                  width: appWidth(context),
                  bgContainerColor: context.bgColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppText(
                        text: 'السعر: ${trip['price'] ?? 'غير محدد'}',
                        textColor: AppColors.whiteColor,
                      ),
                      const VSpace(15),
                      AppDivider(color: AppColors.whiteColor),
                      const VSpace(10),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: const [
                            Icon(Icons.location_on, color: Colors.red),
                            SizedBox(width: 8),
                            CustomAppText(
                              text: "Open Route in Maps",
                              textColor: AppColors.whiteColor,
                            ),
                          ],
                        ),
                      ),
                      const VSpace(15),
                      AppDivider(color: AppColors.whiteColor),
                      const VSpace(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await acceptTrip(trips[index].id);
                              Future.delayed(Duration.zero, () {
                                if (!mounted) return;
                                context.pushNamed(Routes.trippages);
                              });
                            },
                            child: CustomContainer(
                              bgContainerColor: AppColors.greenColor,
                              height: appHeight(context) * 0.07,
                              width: appWidth(context) * 0.4,

                              child: const CustomAppText(
                                text: "Accepted",
                                textColor: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await rejectTrip(trips[index].id);
                            },
                            child: CustomContainer(
                              bgContainerColor: AppColors.redColor,
                              height: appHeight(context) * 0.07,
                              width: appWidth(context) * 0.4,
                              child: const CustomAppText(
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
