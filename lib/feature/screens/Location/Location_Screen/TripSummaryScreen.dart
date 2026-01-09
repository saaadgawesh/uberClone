import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class TripSummaryScreen extends StatelessWidget {
  final LatLng start;
  final LatLng end;
  final double distance;
  final double duration;
  final double price;

  const TripSummaryScreen({
    super.key,
    required this.start,
    required this.end,
    required this.distance,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trip Summary")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Distance: ${distance.toStringAsFixed(2)} km"),
            Text("Duration: ${duration.toStringAsFixed(1)} min"),
            Text("Price: ${price.toStringAsFixed(2)} EGP"),
          ],
        ),
      ),
    );
  }
}
