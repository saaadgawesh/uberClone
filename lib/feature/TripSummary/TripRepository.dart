
import '../../../core/App_Imports/app_imports.dart';

class TripRepository {
  Future<String> selectDriver(TripData tripData, String driverId) async {
    // تأكد من أن المستخدم مسجل دخول
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User not logged in');
    }
    final currentUserId = currentUser.uid;

    // ✅ التأكد أن المستخدم ليس السائق نفسه
    if (currentUserId == driverId) {
      throw Exception("Cannot request your own ride");
    }

    // ✅ التأكد أن driverId موجود في Firestore
    final driverDoc = FirebaseFirestore.instance
        .collection('Driver')
        .doc(driverId);
    final snapshot = await driverDoc.get();
    if (!snapshot.exists) {
      throw Exception("Driver not found");
    }

    // ✅ إنشاء doc جديد في collection "trips"
    final tripRef = FirebaseFirestore.instance.collection('trips').doc();
    await tripRef.set({
      'tripId': tripRef.id,
      'driverId': driverId,
      'riderId': currentUserId,
      'status': 'pending',
      'fromLat': tripData.startLocation.latitude,
      'fromLng': tripData.startLocation.longitude,
      'toLat': tripData.endLocation.latitude,
      'toLng': tripData.endLocation.longitude,
      'price': tripData.price,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await driverDoc.set({'status': 'requested'}, SetOptions(merge: true));

    return tripRef.id;
  }
}
