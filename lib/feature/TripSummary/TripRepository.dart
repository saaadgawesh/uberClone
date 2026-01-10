import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uberCloneRider/feature/TripSummary/data/models/tripModel.dart';

class TripRepository {
  Future<String> selectDriver(TripData tripData, String driverId) async {
    final tripRef = FirebaseFirestore.instance.collection('trips').doc();

    await tripRef.set({
      'tripId': tripRef.id,
      'driverId': driverId,
      'riderId': tripData.riderId,
      'status': 'pending',

      'fromLat': tripData.startLocation.latitude,
      'fromLng': tripData.startLocation.longitude,

      'toLat': tripData.endLocation.latitude,
      'toLng': tripData.endLocation.longitude,

      'price': tripData.price,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance.collection('drivers').doc(driverId).update(
      {'status': 'requested'},
    );

    return tripRef.id; // مهم للراكب
  }
}
