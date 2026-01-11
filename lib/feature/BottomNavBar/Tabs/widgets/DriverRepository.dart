import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Stream الرحلات الخاصة بالسائق
  Stream<QuerySnapshot<Map<String, dynamic>>> getDriverTrips() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    return firestore
        .collection('trips')
        .where('driverId', isEqualTo: currentUser.uid)
        .where('status', isEqualTo: 'pending') // الرحلات الجديدة
        .snapshots();
  }
}
