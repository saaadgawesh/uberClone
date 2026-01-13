import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

// Future<void> payForTrip({
//   required String tripId,
//   required String riderId,
//   required String driverId,
//   required double amount,
// }) async {
//   final paymentRef = FirebaseFirestore.instance.collection('payments').doc();

//   await paymentRef.set({
//     'paymentId': paymentRef.id,
//     'tripId': tripId,
//     'riderId': riderId,
//     'driverId': driverId,
//     'amount': amount,
//     'status': 'success',
//     'createdAt': FieldValue.serverTimestamp(),
//   });

//   await FirebaseFirestore.instance.collection('trips').doc(tripId).update({
//     'status': 'paid',
//   });
// }
Future<void> payForTrip({
  required String tripId,
  required String riderId,
  required double amount,
}) async {
  final firestore = FirebaseFirestore.instance;

  // 1️⃣ جلب بيانات الرحلة للحصول على driverId
  final tripDoc = await firestore.collection('trips').doc(tripId).get();

  if (!tripDoc.exists) {
    throw Exception('Trip not found');
  }

  final driverId = tripDoc['driverId'];

  // 2️⃣ إنشاء payment بحالة pending
  final paymentRef = firestore.collection('payments').doc();

  await paymentRef.set({
    'paymentId': paymentRef.id,
    'tripId': tripId,
    'riderId': riderId,
    'driverId': driverId,
    'amount': amount,
    'status': 'pending',
    'createdAt': FieldValue.serverTimestamp(),
  });

  // 3️⃣ بعد نجاح عملية الدفع (Stripe / Paymob / إلخ)
  await paymentRef.update({
    'status': 'success',
  });

  // 4️⃣ تحديث حالة الرحلة إلى paid
  await firestore.collection('trips').doc(tripId).update({
    'status': 'paid',
  });
}
