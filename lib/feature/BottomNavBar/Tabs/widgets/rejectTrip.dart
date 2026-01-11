import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void rejectTrip(String tripId) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final tripDoc =
      FirebaseFirestore.instance.collection('trips').doc(tripId);
  final driverDoc =
      FirebaseFirestore.instance.collection('Driver').doc(uid);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final tripSnapshot = await transaction.get(tripDoc);

    if (!tripSnapshot.exists) {
      throw Exception('Trip not found');
    }

    // تحديث الرحلة
    transaction.update(tripDoc, {
      'status': 'rejected',
    });

    // إعادة حالة السائق
    transaction.update(driverDoc, {
      'status': 'available',
    });
  });
}
