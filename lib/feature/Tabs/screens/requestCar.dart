// import 'package:flutter/material.dart';
// import 'package:uberCloneRider/core/constant/App_Color.dart';
// import 'package:uberCloneRider/core/resources/App_Size.dart';
// import 'package:uberCloneRider/core/resources/CustomAppText.dart';
// import 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
// import 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
// import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
// import 'package:uberCloneRider/feature/Tabs/widgets/textfieldWithSectionTitle.dart';
// import 'package:uberCloneRider/feature/screens/Location/Location_Screen/LocationScreen.dart';

// class Requests extends StatelessWidget {
//   const Requests({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: DefaultAppBar(title: 'request cars'),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Textfieldwithsectiontitle(
//                 onpressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Locationscreen()),
//                   );
//                 },
//                 iconName: Icons.location_on_outlined,
//                 text: 'get location',
//                 hinttext: 'get location',
//               ),
//               heightSizedbox(10),
//               Textfieldwithsectiontitle(text: 'from', hinttext: 'choose city'),
//               heightSizedbox(10),
//               Textfieldwithsectiontitle(text: 'to', hinttext: 'choose city'),
//               heightSizedbox(10),

//               Textfieldwithsectiontitle(
//                 text: 'type of transport',
//                 hinttext: 'choose city',
//               ),
//               heightSizedbox(10),
//               heightSizedbox(10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   CustomAppText(
//                     text: "350Eg",
//                     textColor: AppColors.greenColor,

//                     fontWeight: FontWeight.w500,
//                   ),
//                   CustomAppText(
//                     text: "tripPrice",
//                     textColor: AppColors.blueColor,

//                     fontWeight: FontWeight.w500,
//                   ),
//                 ],
//               ),
//               heightSizedbox(10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomAppText(
//                     text: "time",
//                     textColor: AppColors.blueColor,

//                     fontWeight: FontWeight.w500,
//                   ),
//                   CustomAppText(
//                     text: "date",
//                     textColor: AppColors.blueColor,

//                     fontWeight: FontWeight.w500,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   defaultElevatedButton(
//                     textbutton: "PM 06:46",
//                     bgButtonColor: AppColors.greyColor,
//                     onPressed: () {},
//                     iconName: Icons.alarm,
//                     iconColor: AppColors.blackColorwithopacity,
//                     width: appWidth(context) * 0.47,
//                     textcolor: AppColors.blackColorwithopacity,
//                   ),
//                   defaultElevatedButton(
//                     textbutton: "25-11-16",
//                     bgButtonColor: AppColors.greyColor,
//                     onPressed: () {},
//                     iconName: Icons.date_range,
//                     iconColor: AppColors.blackColorwithopacity,
//                     width: appWidth(context) * 0.47,
//                     textcolor: AppColors.blackColorwithopacity,
//                   ),
//                 ],
//               ),
//               heightSizedbox(10),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: defaultElevatedButton(
//           textbutton: "request now",
//           bgButtonColor: AppColors.blueColor,
//           onPressed: () {},

//           width: appWidth(context),
//           textcolor: AppColors.whiteColor,
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:uberCloneRider/feature/screens/Location/Location_Controller/Location_Manager.dart';
import 'package:uberCloneRider/feature/screens/TripSummaryScreen/screen/TripSummaryScreen.dart';

class Requestcar extends StatefulWidget {
  const Requestcar({super.key});

  @override
  State<Requestcar> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Requestcar> {
  final TextEditingController _locationController = TextEditingController();

  late final MapController _mapController;
  final LocationManager locationManager = LocationManager();

  LatLng? _currentLocation;
  LatLng? _destination;

  final List<LatLng> _route = [];

  bool isLoading = false;
  double? tripdistancekm;
  double? tripdistancemin;

  // ================= POLYLINE DECODER =================
  List<LatLng> decodePolyline(String encoded) {
    final points = PolylinePoints.decodePolyline(encoded);
    return points.map((e) => LatLng(e.latitude, e.longitude)).toList();
  }

  final double baseFare = 10;
  final double pricePerKm = 5;
  final double pricePerMin = 1;
  double calculatePrice() {
    if (tripdistancekm == null || tripdistancemin == null) return 0;

    return baseFare +
        (tripdistancekm! * pricePerKm) +
        (tripdistancemin! * pricePerMin);
  }

  //====================searchResults===========
  List<dynamic> searchResults = [];
  bool showResults = false;

  // ================= INIT =================
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initializeLocation();
    });
  }

  //==================dispose===========================
  @override
  void dispose() {
    _locationController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  // ================= CURRENT LOCATION =================
  Future<void> initializeLocation() async {
    setState(() => isLoading = true);

    final locationData = await locationManager.getUserLocation();
    if (locationData == null) {
      setState(() => isLoading = false);
      return;
    }
    if (!mounted) return;
    setState(() {
      _currentLocation = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
      isLoading = false;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _mapController.move(_currentLocation!, 15);
    });
  }

  // ================= FETCH ROUTE =================
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
    final geometry = data['routes'][0]['geometry'];
    final route = data['routes'][0];
    tripdistancekm = route['distance'] / 1000;
    tripdistancemin = route['distance'] / 60;
    if (!mounted) return;
    setState(() {
      _route.clear();
      _route.addAll(decodePolyline(geometry));
    });
  }

  // ================= FETCH DESTINATION =================
  Future<void> fetchCoordinatePoint(String location) async {
    final encodedQuery = Uri.encodeComponent(location);

    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search"
      "?q=$encodedQuery"
      "&format=json"
      "&addressdetails=1"
      "&limit=1",
    );

    try {
      final response = await http.get(
        url,
        headers: {
          "User-Agent": "UberCloneRider/1.0 (contact: dev@uberclone.com)",
          "Accept": "application/json",
        },
      );

      if (response.statusCode != 200) {
        debugPrint("Nominatim error: ${response.statusCode}");
        debugPrint(response.body);
        if (!mounted) return;
        showSnackBar(context, "Location service unavailable");
        return;
      }

      final List data = jsonDecode(response.body);

      if (data.isEmpty) {
        if (!mounted) return;
        showSnackBar(context, "Location not found");
        return;
      }

      final lat = double.parse(data[0]['lat']);
      final lon = double.parse(data[0]['lon']);

      setState(() {
        _destination = LatLng(lat, lon);
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.move(_destination!, 15);
      });

      await fetchRoute();
    } catch (e) {
      debugPrint("Search error: $e");
      if (!mounted) return;
      showSnackBar(context, "Search failed");
    }
  }

  //========================searchPlaces===========================================
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
      "?q=$encodedQuery"
      "&format=json"
      "&addressdetails=1"
      "&limit=5",
    );

    final response = await http.get(
      url,
      headers: {
        "User-Agent": "UberCloneRider/1.0 (contact: dev@uberclone.com)",
      },
    );

    if (response.statusCode != 200) return;

    setState(() {
      searchResults = jsonDecode(response.body);
      showResults = true;
    });
  }

  //======================firebase============================
  Future<void> createTrip() async {
    final tripRef = FirebaseFirestore.instance.collection('trips').doc();

    await tripRef.set({
      "riderId": "USER_ID",
      "driverId": null,
      "startLat": _currentLocation!.latitude,
      "startLng": _currentLocation!.longitude,
      "endLat": _destination!.latitude,
      "endLng": _destination!.longitude,
      "distanceKm": tripdistancekm,
      "durationMin": tripdistancemin,
      "price": calculatePrice(),
      "status": "searching",
      "createdAt": FieldValue.serverTimestamp(),
    });

    listenForDriver(tripRef.id);
  }

  void listenForDriver(String tripId) {
    FirebaseFirestore.instance
        .collection('trips')
        .doc(tripId)
        .snapshots()
        .listen((snapshot) {
          if (snapshot.exists && snapshot['status'] == 'accepted') {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => DriverOnWayScreen(),
            //   ),
            // );
          }
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
                    minZoom: 3,
                    maxZoom: 18,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    ),

                    /// Current location marker
                    CurrentLocationLayer(
                      style: LocationMarkerStyle(
                        marker: DefaultLocationMarker(
                          child: Icon(
                            Icons.location_pin,
                            color: AppColors.whiteColor,
                            size: 18,
                          ),
                        ),
                        markerSize: const Size(35, 35),
                      ),
                    ),

                    /// Destination marker
                    if (_destination != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 35,
                            height: 35,
                            point: _destination!,
                            child: customAppIcon(
                              iconName: Icons.location_pin,
                              iconColor: AppColors.redColor,
                            ),
                          ),
                        ],
                      ),

                    /// Route polyline
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

          /// Search bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: AppTextField(
                onFieldSubmitted: (value) {
                  searchPlaces(value);
                },
                controller: _locationController,
                hintText: "Search place",
                hintStyle: TextStyle(color: AppColors.blueColor),

                filledColor: AppColors.whiteColor,
                prefix: IconButton(
                  icon: customAppIcon(iconName: Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                suffix: IconButton(
                  icon: customAppIcon(iconName: Icons.search),
                  onPressed: () {
                    final value = _locationController.text.trim();
                    if (value.isNotEmpty) {
                      fetchCoordinatePoint(value);
                    } else {
                      showSnackBar(context, "Search for a place");
                    }
                  },
                ),
              ),
            ),
          ),

          if (showResults)
            Positioned(
              top: appHeight(context) * 0.14,
              left: appWidth(context) * 0.05,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final place = searchResults[index];
                    return ListTile(
                      title: Text(
                        place['display_name'],
                        style: TextStyle(color: AppColors.blueColor),
                      ),
                      onTap: () {
                        final lat = double.parse(place['lat']);
                        final lon = double.parse(place['lon']);

                        setState(() {
                          _destination = LatLng(lat, lon);
                          showResults = false;
                          _locationController.text = place['display_name'];
                        });

                        _mapController.move(_destination!, 15);
                        fetchRoute();
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      AppDivider(),
                ),
              ),
            ),
        ],
      ),

      floatingActionButton: defaultFloatingActionButton(
        onpressed: initializeLocation,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: defaultElevatedButton(
          textbutton: "Confirm Location",
          bgButtonColor: AppColors.blueColor,
          onPressed: () {
            if (_destination == null) {
              showSnackBar(context, "Select destination first");
              return;
            }

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TripSummaryScreen(
                  start: _currentLocation!,
                  end: _destination!,
                  distance: tripdistancekm!,
                  duration: tripdistancekm!,
                  price: calculatePrice(),
                ),
              ),
            );
          },
          width: appWidth(context) * 0.87,
          textcolor: AppColors.whiteColor,
        ),
      ),
    );
  }
}
