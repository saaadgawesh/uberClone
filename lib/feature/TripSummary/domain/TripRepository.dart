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

    final riderDoc = await FirebaseFirestore.instance
        .collection('Rider')
        .doc(currentUserId)
        .get();
    final riderName = (riderDoc.data()?['name'] ?? tripmodel.riderName).toString();
    final driverData = snapshot.data() ?? <String, dynamic>{};

    final tripRef = FirebaseFirestore.instance.collection('trips').doc();

    final tripData = tripmodel.toMap()
      ..addAll({
        'tripId': tripRef.id,
        'driverId': driverId,
        'riderId': currentUserId,
        'riderName': riderName,
        'driverName': (driverData['name'] ?? '').toString(),
        'driverPhone': driverData['phone']?.toString(),
        'driverCarModel': (driverData['carModel'] ?? '').toString(),
        'driverCarNumber': (driverData['carNumber'] ?? '').toString(),
        'status': 'requested',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

    await tripRef.set(tripData);

    await driverDoc.set({
      'status': 'requested',
      'currentTripId': tripRef.id,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return tripRef.id;
  }
}
