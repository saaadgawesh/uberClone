import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:uberCloneDriver/feature/Location/Location_Controller/Location_Manager.dart';

class Locationscreen extends StatefulWidget {
  final LatLng start; // موقع بداية الرحلة من الراكب
  final LatLng end; // موقع النهاية من الراكب

  const Locationscreen({super.key, required this.start, required this.end});

  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  late final MapController _mapController;
  final LocationManager locationManager = LocationManager();

  LatLng? _currentLocation;
  late LatLng _destination;
  final List<LatLng> _route = [];

  double? tripdistancekm;
  double? tripdistancemin;
  double? _currentZoom = 15;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _destination = widget.end;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await initializeTracking();
    });
  }

  Future<void> initializeTracking() async {
    // Set start location as initial current location
    _currentLocation = widget.start;

    // Fetch route from current location إلى destination
    await fetchRoute();

    // Move map to current location
    _mapController.move(_currentLocation!, 15);

    // Start continuous tracking
    locationManager.startTracking((LatLng newLocation) {
      setState(() {
        _currentLocation = newLocation;
        _route.insert(0, newLocation); // optional: update route
        _mapController.move(newLocation, 15);
      });
    });

    setState(() => isLoading = false);
  }

  // ====== FETCH ROUTE FROM CURRENT TO DESTINATION ======
  Future<void> fetchRoute() async {
    if (_currentLocation == null || _destination == null) return;

    final url = Uri.parse(
      "https://router.project-osrm.org/route/v1/driving/"
      "${_currentLocation!.longitude},${_currentLocation!.latitude};"
      "${_destination.longitude},${_destination.latitude}"
      "?overview=full&geometries=polyline",
    );

    final response = await http.get(url);
    if (response.statusCode != 200) return;

    final data = jsonDecode(response.body);
    final geometry = data['routes'][0]['geometry'];
    final route = data['routes'][0];
    tripdistancekm = route['distance'] / 1000;
    tripdistancemin = route['duration'] / 60;

    setState(() {
      _route.clear();
      _route.addAll(decodePolyline(geometry));
    });
  }

  List<LatLng> decodePolyline(String encoded) {
    final points = PolylinePoints.decodePolyline(encoded);
    return points.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }

  @override
  void dispose() {
    locationManager.stopTracking();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation!,
                maxZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),

                /// السائق الحالي
                if (_currentLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _currentLocation!,
                        width: 35,
                        height: 35,
                        child: Icon(
                          Icons.directions_car,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                /// الوجهة
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _destination,
                      width: 35,
                      height: 35,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 35,
                      ),
                    ),
                  ],
                ),

                /// خط الرحلة
                if (_route.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: _route,
                        color: Colors.red,
                        strokeWidth: 5,
                      ),
                    ],
                  ),
              ],
            ),
    );
  }
}
