import "../../../../core/App_Imports/app_imports.dart";

/// قبول الرحلة
Future<void> acceptTrip(String tripId) async {
  final driverId = FirebaseAuth.instance.currentUser!.uid;
  final tripRef = FirebaseFirestore.instance.collection('trips').doc(tripId);

  // 1️⃣ تحديث حالة الرحلة
  await tripRef.update({'status': 'accepted', 'driverId': driverId});

  // 2️⃣ تحديث حالة السائق
  await FirebaseFirestore.instance.collection('Driver').doc(driverId).update({
    'status': 'busy',
  });

  // 3️⃣ إشعار الراكب محليًا (إذا كان عنده NotificationService)
  final tripSnap = await tripRef.get();
  final riderName = tripSnap['riderName'] ?? 'راكب جديد';
  final tripType = 'trip_accepted';

  NotificationService().showNotification(
    title: '✅ تم قبول الرحلة',
    body: '$riderName، السائق وافق على رحلتك',
    payload: tripId,
  );
}
