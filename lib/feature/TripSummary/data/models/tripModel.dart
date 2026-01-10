import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class TripData {
  final String tripId;
  final String riderId;
  final String driverId;

  final LatLng startLocation;
  final LatLng endLocation;

  final String startAddress;
  final String endAddress;

  final double durationMin;
  final double price;
  final double distanceKm;

  final String status;
  final DateTime createdAt;

  TripData({
    required this.tripId,
    required this.riderId,
    required this.driverId,
    required this.startLocation,
    required this.endLocation,
    required this.startAddress,
    required this.endAddress,
    required this.durationMin,
    required this.price,
    required this.distanceKm,
    required this.status,
    required this.createdAt,
  });

  /// 🔁 تحويل إلى Map للتخزين في Firestore
  Map<String, dynamic> toMap() {
    return {
      'tripId': tripId,
      'riderId': riderId,
      'driverId': driverId,
      'startLocation': startLocation,
      'endLocation': endLocation,
      'startAddress': startAddress,
      'endAddress': endAddress,
      'durationMin': durationMin,
      'price': price,
      'distanceKm': distanceKm,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// 🔁 إنشاء Object من Firestore
  factory TripData.fromMap(Map<String, dynamic> map) {
    return TripData(
      tripId: map['tripId'] ?? '',
      riderId: map['riderId'] ?? '',
      driverId: map['driverId'] ?? '',
      startLocation: map['startLocation'] ?? '',
      endLocation: map['endLocation'] ?? '',
      startAddress: map['startAddress'] ?? '',
      endAddress: map['endAddress'] ?? '',
      durationMin: (map['durationMin'] as num?)?.toDouble() ?? 0.0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      distanceKm: (map['distanceKm'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] ?? 'pending',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
