import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/resources/AppDivider.dart';
import 'package:uberCloneDriver/core/resources/customAppIcon.dart';
import 'package:uberCloneDriver/feature/TripSummary/data/models/tripModel.dart';
import 'package:uberCloneDriver/feature/TripSummary/presentation/screen/TripSummaryScreen.dart';

class Requests extends StatefulWidget {
  final String? tripId; // معرف الرحلة

  const Requests({super.key, this.tripId});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  late final MapController _mapController;

  LatLng? _startLocation;
  LatLng? _endLocation;
  String? _startAddress;
  String? _endAddress;
  double? _distanceKm;
  double? _durationMin;
  double? _price;
  final List<LatLng> _route = [];

  final double baseFare = 10;
  final double pricePerKm = 5;
  final double pricePerMin = 1;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  List<LatLng> decodePolyline(String encoded) {
    final points = PolylinePoints.decodePolyline(encoded);
    return points.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }

  double calculatePrice(double distance, double duration) {
    final price = baseFare + (distance * pricePerKm) + (duration * pricePerMin);
    return price.clamp(20, 500);
  }

  Future<void> updateRoute(String polyline) async {
    final decoded = decodePolyline(polyline);
    setState(() {
      _route
        ..clear()
        ..addAll(decoded);
    });
    if (_startLocation != null) _mapController.move(_startLocation!, 13);
  }

  @override
  Widget build(BuildContext context) {
    // التأكد من وجود tripId
    if (widget.tripId == null || widget.tripId!.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            "Trip ID غير موجود",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Trips")
          .doc(widget.tripId!)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            body: Center(
              child: Text(
                "لا توجد بيانات للرحلة",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          );
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;

        // ===== استلام البيانات من Firestore =====
        final startLat = (data['startLocation']['lat'] as num).toDouble();
        final startLng = (data['startLocation']['lng'] as num).toDouble();
        final endLat = (data['endLocation']['lat'] as num).toDouble();
        final endLng = (data['endLocation']['lng'] as num).toDouble();
        final distance = (data['distanceKm'] as num).toDouble();
        final duration = (data['durationMin'] as num).toDouble();
        final polyline = data['polyline'] ?? "";

        _startLocation = LatLng(startLat, startLng);
        _endLocation = LatLng(endLat, endLng);
        _startAddress = data['startAddress'] ?? "Unknown";
        _endAddress = data['endAddress'] ?? "Unknown";
        _distanceKm = distance;
        _durationMin = duration;
        _price = calculatePrice(distance, duration);

        if (polyline.isNotEmpty) {
          updateRoute(polyline);
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Trip Details"),
            backgroundColor: AppColors.blueColor,
          ),
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter:
                      _startLocation ?? const LatLng(30.0444, 31.2357),
                  initialZoom: 13,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  if (_startLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _startLocation!,
                          width: 35,
                          height: 35,
                          child: customAppIcon(
                            iconName: Icons.my_location,
                            iconColor: AppColors.greenColor,
                          ),
                        ),
                      ],
                    ),
                  if (_endLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _endLocation!,
                          width: 35,
                          height: 35,
                          child: customAppIcon(
                            iconName: Icons.location_pin,
                            iconColor: AppColors.redColor,
                          ),
                        ),
                      ],
                    ),
                  if (_route.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: _route,
                          strokeWidth: 5,
                          color: AppColors.redColor,
                        ),
                      ],
                    ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From: $_startAddress"),
                      AppDivider(),
                      Text("To: $_endAddress"),
                      AppDivider(),
                      Text("Distance: ${_distanceKm?.toStringAsFixed(2)} km"),
                      AppDivider(),
                      Text("Duration: ${_durationMin?.toStringAsFixed(0)} min"),
                      AppDivider(),
                      Text("Price: \$${_price?.toStringAsFixed(2)}"),
                      AppDivider(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_startLocation != null &&
                                _endLocation != null) {
                              final tripPreview = TripData(
                                id: widget.tripId!,

                                startLocation: _startLocation!,
                                endLocation: _endLocation!,
                                startAddress: _startAddress!,
                                endAddress: _endAddress!,
                                distanceKm: _distanceKm!,
                                durationMin: _durationMin!,
                                price: _price!,
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      TripSummaryScreen(tripData: tripPreview),
                                ),
                              );
                            }
                          },
                          child: const Text("View Trip Summary"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
