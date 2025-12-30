import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:uber/core/constant/App_Color.dart';
import 'package:uber/core/constant/api_Constant.dart';
import 'package:uber/core/resources/AppDivider.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/customAppIcon.dart';
import 'package:uber/core/resources/customAppText.dart';
import 'package:uber/core/widgets/App_TextField.dart';
import 'package:uber/core/widgets/CustomContainer.dart';
import 'package:uber/core/widgets/defaultElevatedButton.dart';
import 'package:uber/core/widgets/showSnackbar.dart';
import 'package:uber/feature/presentation/models/locationModel.dart';
import 'package:uber/feature/presentation/widgets/Location_Manager.dart';

class Locationscreen extends StatefulWidget {
  const Locationscreen({super.key});

  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Marker> markers = [];
  List<PlaceResult> searchResults = [];
  bool showResults = false;
  final ApiConstant apiConstant = ApiConstant();

  late final MapController _mapController;
  final locationmanager = LocationManager();

  /// ================= SEARCH =================

  Future<void> searchPlace(String place) async {
    final url = Uri.parse(apiConstant.searchPlace(place));
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List features = data['features'];

      setState(() {
        searchResults = features.map((item) {
          final coords = item['geometry']['coordinates'];
          return PlaceResult(
            name: item['place_name'],
            location: LatLng(coords[1], coords[0]),
          );
        }).toList();
        showResults = true;
      });
    }
  }

  /// ================= SELECT PLACE =================
  void selectPlace(PlaceResult place) {
    setState(() {
      searchController.text = place.name;
      showResults = false;
      searchResults.clear();
      markers.clear();

      markers.add(
        Marker(
          point: place.location,
          width: 40,
          height: 40,
          child:
          // const Icon(Icons.location_pin, color: Colors.red, size: 40),
          customAppIcon(AppColor.redColor, Icons.location_pin, 40)
        ),
      );
    });

    _mapController.move(place.location, 16);
  }

  /// ================= INIT and DISPOSE=================
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getUserLocation();
  }

  @override
  void dispose() {
    searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  /// ================= USER LOCATION =================
  Future<void> _getUserLocation() async {
    final locationData = await locationmanager.getUserLocation();
    if (locationData == null) return;

    final LatLng currentLocation = LatLng(
      locationData.latitude!,
      locationData.longitude!,
    );

    _mapController.move(currentLocation, 16);
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// ================= MAP =================
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(30.0444, 31.2357), // Cairo
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate: apiConstant.mapTileUrl,
                // ignore: deprecated_member_use
                tileSize: 512,
                zoomOffset: -1,
              ),
              MarkerLayer(markers: markers),
            ],
          ),

          /// ================= SEARCH + RESULTS =================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTextField(
                    cursorHeight: 15,
                    prefix: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Locationscreen(),
                          ),
                        );
                      },
                      icon: customAppIcon(
                        AppColor.blueColor,
                        Icons.arrow_back_ios,20
                      ),
                    ),
                    suffix: IconButton(
                      icon: customAppIcon(AppColor.blueColor, Icons.search,20),
                      onPressed: () {
                        final query = searchController.text.trim();
                        if (query.isEmpty) {
                          showSnackBar(
                            context,
                            "search about place",
                            AppColor.redColor,
                          );
                          return;
                        }
                        searchPlace(query);
                      },
                    ),

                    controller: searchController,
                    hintText: "",
                    filledColor: AppColor.whiteColor,
                    onFieldSubmitted: (value) {
                      if (value.length > 2) {
                        searchPlace(value);
                      } else {
                        setState(() => showResults = false);
                      }
                    },
                  ),

                  if (showResults)
                    CustomContainer(
                      height: 220,
                      width: appWidth(context),
                      borderRadius: BorderRadius.circular(8),
                      bgContainerColor: AppColor.whiteColor,
                      child: ListView.separated(
                        itemCount: searchResults.length,
                        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                        separatorBuilder: (BuildContext, int) =>
                            const AppDivider(),
                        itemBuilder: (context, index) {
                          final place = searchResults[index];
                          return ListTile(
                            leading: const Icon(Icons.location_on_outlined),
                            title: customAppText(
                              text: place.name,
                              textColor: AppColor.blackColor,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () => selectPlace(place),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),

          /// ================= BUTTON =================
          Positioned(
            bottom: 10,
            left: 16,
            right: 16,
            child: defaultElevatedButton(
              textbutton: "Confirm Location",
              bgButtonColor: AppColor.blueColor,
              onPressed: () {},
              width: appWidth(context) * 0.87,
              textcolor: AppColor.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
