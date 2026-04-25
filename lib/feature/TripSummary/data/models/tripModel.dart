import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';

class Tripmodel {
  final String tripId;
  final String riderId;
  final String riderName;
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

  Tripmodel({
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
    required this.riderName,
  });

  /// 🔁 تحويل إلى Map للتخزين في Firestore
  Map<String, dynamic> toMap() {
    return {
      'tripId': tripId,
      'riderId': riderId,
      'riderName': riderName,
      'driverId': driverId,
      'fromLat': startLocation.latitude,
      'fromLng': startLocation.longitude,
      'toLat': endLocation.latitude,
      'toLng': endLocation.longitude,
      'startLocation': {
        'lat': startLocation.latitude,
        'lng': startLocation.longitude,
      },
      'endLocation': {
        'lat': endLocation.latitude,
        'lng': endLocation.longitude,
      },
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
  factory Tripmodel.fromMap(Map<String, dynamic> map) {
    final startLocationMap =
        (map['startLocation'] as Map<String, dynamic>?) ??
        {
          'lat': map['fromLat'],
          'lng': map['fromLng'],
        };
    final endLocationMap =
        (map['endLocation'] as Map<String, dynamic>?) ??
        {
          'lat': map['toLat'],
          'lng': map['toLng'],
        };

    return Tripmodel(
      tripId: map['tripId'] ?? '',
      riderId: map['riderId'] ?? '',
      riderName: map['riderName'] ?? '',
      driverId: map['driverId'] ?? '',
      startLocation: LatLng(
        (startLocationMap['lat'] as num?)?.toDouble() ?? 0.0,
        (startLocationMap['lng'] as num?)?.toDouble() ?? 0.0,
      ),
      endLocation: LatLng(
        (endLocationMap['lat'] as num?)?.toDouble() ?? 0.0,
        (endLocationMap['lng'] as num?)?.toDouble() ?? 0.0,
      ),
      startAddress:
          (map['startAddress'] ?? map['fromAddress'] ?? '').toString(),
      endAddress: (map['endAddress'] ?? map['toAddress'] ?? '').toString(),
      durationMin: (map['durationMin'] as num?)?.toDouble() ?? 0.0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      distanceKm: (map['distanceKm'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] ?? 'requested',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
