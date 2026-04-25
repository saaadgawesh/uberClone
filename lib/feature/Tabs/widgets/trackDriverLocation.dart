import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// تتبع موقع السائق لايف
Stream<LatLng> trackDriverLocation(String driverId) {
  return FirebaseFirestore.instance
      .collection('Driver')
      .doc(driverId)
      .snapshots()
      .map((doc) {
        if (!doc.exists) throw Exception('Driver not found');
        final data = doc.data()!;

        final location = data['location'];
        if (location is GeoPoint) {
          return LatLng(location.latitude, location.longitude);
        }

        if (location is Map<String, dynamic>) {
          final lat = (location['lat'] as num?)?.toDouble();
          final lng = (location['lng'] as num?)?.toDouble();
          if (lat != null && lng != null) {
            return LatLng(lat, lng);
          }
        }

        final lat = (data['lat'] as num?)?.toDouble();
        final lng = (data['lng'] as num?)?.toDouble();
        if (lat != null && lng != null) {
          return LatLng(lat, lng);
        }

        throw Exception('Location not found');
      });
}
