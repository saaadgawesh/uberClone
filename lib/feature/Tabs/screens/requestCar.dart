import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/resources/AppDivider.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/customAppIcon.dart';
import 'package:uberCloneRider/core/widgets/App_TextField.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneRider/core/widgets/defaultFloatingActionButton.dart';
import 'package:uberCloneRider/core/widgets/showSnackbar.dart';
import 'package:uberCloneRider/feature/Location/Location_Controller/Location_Manager.dart';
import 'package:uberCloneRider/feature/TripSummary/data/models/tripModel.dart';
import 'package:uberCloneRider/feature/TripSummary/presentation/screen/TripSummaryScreen.dart';

class Requestcar extends StatefulWidget {
  const Requestcar({super.key});

  @override
  State<Requestcar> createState() => _RequestcarState();
}

class _RequestcarState extends State<Requestcar> {
  final TextEditingController _locationController = TextEditingController();
  late final MapController _mapController;

  final LocationManager locationManager = LocationManager();

  /// locations
  LatLng? _currentLocation;
  LatLng? _destination;

  /// addresses
  String? _currentAddress;
  String? _destinationAddress;
  String? currentUserId;
  String? selectedDriverId;

  /// route
  final List<LatLng> _route = [];

  bool isLoading = false;

  double? tripdistancekm;
  double? tripdistancemin;

  /// pricing
  final double baseFare = 10;
  final double pricePerKm = 5;
  final double pricePerMin = 1;

  /// search
  List<dynamic> searchResults = [];
  bool showResults = false;

  // ================= INIT =================
  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeLocation();
    });
  }

  @override
  void dispose() {
    _locationController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  // ================= REVERSE GEOCODING =================
  Future<String?> getAddressFromLatLng(LatLng location) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse'
      '?lat=${location.latitude}'
      '&lon=${location.longitude}'
      '&format=json',
    );

    final response = await http.get(
      url,
      headers: {'User-Agent': 'UberCloneRider/1.0'},
    );

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    return data['display_name'];
  }

  // ================= POLYLINE =================
  List<LatLng> decodePolyline(String encoded) {
    final points = PolylinePoints.decodePolyline(encoded);
    return points.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }

  // ================= PRICE =================
  double calculatePrice() {
    if (tripdistancekm == null || tripdistancemin == null) return 0;

    final price =
        baseFare +
        (tripdistancekm! * pricePerKm) +
        (tripdistancemin! * pricePerMin);

    return price.clamp(20, 500);
  }

  // ================= LOCATION =================
  Future<void> initializeLocation() async {
    setState(() => isLoading = true);

    final locationData = await locationManager.getUserLocation();
    if (locationData == null) {
      setState(() => isLoading = false);
      return;
    }

    if (!mounted) return;

    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    final address = await getAddressFromLatLng(latLng);

    setState(() {
      _currentLocation = latLng;
      _currentAddress = address ?? "Unknown Location";
      isLoading = false;
    });
    _mapController.move(_currentLocation!, 15);
  }

  // ================= ROUTE =================
  Future<void> fetchRoute() async {
    if (_currentLocation == null || _destination == null) return;

    final url = Uri.parse(
      "https://router.project-osrm.org/route/v1/driving/"
      "${_currentLocation!.longitude},${_currentLocation!.latitude};"
      "${_destination!.longitude},${_destination!.latitude}"
      "?overview=full&geometries=polyline",
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      if (!mounted) return;
      showSnackBar(context, "Failed to fetch route");
      return;
    }

    final data = jsonDecode(response.body);
    final route = data['routes'][0];

    tripdistancekm = route['distance'] / 1000;
    tripdistancemin = route['duration'] / 60;

    setState(() {
      _route
        ..clear()
        ..addAll(decodePolyline(route['geometry']));
    });
  }

  // ================= SEARCH =================
  Future<void> searchPlaces(String query) async {
    if (query.length < 3) {
      setState(() {
        showResults = false;
        searchResults.clear();
      });
      return;
    }

    final encodedQuery = Uri.encodeComponent(query);
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search"
      "?q=$encodedQuery&format=json&limit=5",
    );

    final response = await http.get(
      url,
      headers: {"User-Agent": "UberCloneRider/1.0"},
    );

    if (response.statusCode != 200) return;

    setState(() {
      searchResults = jsonDecode(response.body);
      showResults = true;
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter:
                        _currentLocation ?? const LatLng(30.0444, 31.2357),
                    initialZoom: 13,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    ),
                    const CurrentLocationLayer(),

                    if (_destination != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _destination!,
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

          /// search bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AppTextField(
                controller: _locationController,
                hintText: "Search destination",
                onFieldSubmitted: searchPlaces,
                prefix: IconButton(
                  icon: customAppIcon(iconName: Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                suffix: IconButton(
                  icon: customAppIcon(iconName: Icons.search),
                  onPressed: () => searchPlaces(_locationController.text),
                ),
              ),
            ),
          ),

          if (showResults)
            Positioned(
              top: appHeight(context) * 0.14,
              left: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: searchResults.length,
                  itemBuilder: (_, index) {
                    final place = searchResults[index];
                    return ListTile(
                      title: Text(place['display_name']),
                      onTap: () {
                        setState(() {
                          _destination = LatLng(
                            double.parse(place['lat']),
                            double.parse(place['lon']),
                          );
                          _destinationAddress = place['display_name'];
                          _locationController.text = place['display_name'];
                          showResults = false;
                        });

                        _mapController.move(_destination!, 15);
                        fetchRoute();
                      },
                    );
                  },
                  separatorBuilder: (_, __) => AppDivider(),
                ),
              ),
            ),
        ],
      ),

      floatingActionButton: defaultFloatingActionButton(
        onpressed: initializeLocation,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: defaultElevatedButton(
          textbutton: "Confirm Location",
          bgButtonColor: AppColors.blueColor,
          width: appWidth(context) * 0.9,
          textcolor: AppColors.whiteColor,
          onPressed: () {
            if (_currentLocation == null ||
                _destination == null ||
                tripdistancekm == null ||
                tripdistancemin == null) {
              showSnackBar(context, "Select destination first");
              return;
            }

            final tripPreview = TripData(
              tripId: '', // هنملأه بعد شوية
              riderId: FirebaseAuth.instance.currentUser!.uid,
              driverId: "",
              startLocation: _currentLocation!,
              endLocation: _destination!,
              startAddress: _currentAddress ?? "Unknown Location",
              endAddress: _destinationAddress ?? "",
              distanceKm: tripdistancekm!,
              durationMin: tripdistancemin!,
              price: calculatePrice(),
              status: 'pending',
              createdAt: DateTime.now(),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TripSummaryScreen(tripData: tripPreview),
              ),
            );
          },
        ),
      ),
    );
  }
}
