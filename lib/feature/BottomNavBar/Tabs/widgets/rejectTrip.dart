


import"../../../../core/App_Imports/app_imports.dart";
Future<void> rejectTrip(String tripId) async {
  final driverId = FirebaseAuth.instance.currentUser!.uid;
  final tripRef = FirebaseFirestore.instance.collection('trips').doc(tripId);
  final tripSnap = await tripRef.get();
  if (!tripSnap.exists) return;

  final trip = tripSnap.data()!;
  final rejectedDrivers = List<String>.from(trip['rejectedDrivers'] ?? []);
  rejectedDrivers.add(driverId); // منع نفس السواق من إعادة الرحلة

  // تحديث حالة الرحلة
  await tripRef.update({
    'status': 'waiting_driver',
    'driverId': null,
    'rejectedDrivers': rejectedDrivers,
  });

  // إشعار الراكب
  final riderName = trip['riderName'] ?? 'راكب جديد';
  NotificationService().showNotification(
    title: '🚗 تم رفض الرحلة',
    body: '$riderName، السائق رفض الرحلة، نبحث عن سائق آخر',
    payload: tripId,
  );

  // إرسال الرحلة للسواق الجديد (أول سواق متاح)
  await sendToNextNearestDriver(tripId, rejectedDrivers);
}
