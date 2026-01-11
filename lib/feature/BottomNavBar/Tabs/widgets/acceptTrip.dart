
  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// دالة قبول الرحلة
  void acceptTrip(String tripId) async {
    final tripDoc = FirebaseFirestore.instance.collection('trips').doc(tripId);
    final driverDoc = FirebaseFirestore.instance
        .collection('Driver')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    // تحديث حالة الرحلة والسائق
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final tripSnapshot = await transaction.get(tripDoc);
      if (!tripSnapshot.exists) throw Exception('Trip not found');

      transaction.update(tripDoc, {'status': 'accepted'});
      transaction.update(driverDoc, {'status': 'busy'});
    });
  }
