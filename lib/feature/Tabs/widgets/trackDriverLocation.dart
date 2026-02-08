import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// تتبع موقع السائق لايف
Stream<LatLng> trackDriverLocation(String driverId) {
  return FirebaseFirestore.instance
      .collection('drivers')
      .doc(driverId)
      .snapshots()
      .map((doc) {
        if (!doc.exists) throw Exception('Driver not found');
        final data = doc.data()!;
        if (!data.containsKey('location')) {
          throw Exception('Location not found');
        }
        final geoPoint = data['location'] as GeoPoint;
        return LatLng(geoPoint.latitude, geoPoint.longitude);
      });
}
