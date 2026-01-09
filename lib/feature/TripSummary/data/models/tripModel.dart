import 'package:latlong2/latlong.dart';

class TripData {
  final LatLng startLocation;
  final LatLng endLocation;

  final String startAddress;
  final String endAddress;

  final double distanceKm;
  final double durationMin;
  final double price;

  const TripData({
    required this.startLocation,
    required this.endLocation,
    required this.startAddress,
    required this.endAddress,
    required this.distanceKm,
    required this.durationMin,
    required this.price,
  });
}
