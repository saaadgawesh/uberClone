import '../../../../core/App_Imports/app_imports.dart';

class TripRepository {
  Future<String> selectDriver(Tripmodel tripmodel, String driverId) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    final currentUserId = currentUser.uid;

    if (currentUserId == driverId) {
      throw Exception("Cannot request your own ride");
    }

    final driverDoc =
        FirebaseFirestore.instance.collection('Driver').doc(driverId);

    final snapshot = await driverDoc.get();
    if (!snapshot.exists) {
      throw Exception("Driver not found");
    }

    final tripRef = FirebaseFirestore.instance.collection('trips').doc();

    await tripRef.set({
      'tripId': tripRef.id,
      'driverId': driverId,
      'riderId': currentUserId,
      'riderName': tripmodel.riderName,
      'status': 'requested',
      'fromLat': tripmodel.startLocation.latitude,
      'fromLng': tripmodel.startLocation.longitude,
      'toLat': tripmodel.endLocation.latitude,
      'toLng': tripmodel.endLocation.longitude,
      'price': tripmodel.price,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await driverDoc.set({'status': 'requested'}, SetOptions(merge: true));

    return tripRef.id;
  }
}
