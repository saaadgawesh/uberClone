
  import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:uberCloneRider/core/App_Imports/app_imports.dart' ;


/// عرض خريطة موقع السائق في Dialog
  void showDriverLocationDialog(BuildContext context, String driverId) {
      GoogleMapController? _mapController;
  LatLng? _lastLocation;

    _mapController = null;
    _lastLocation = null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: double.infinity,
            height: 300,
            child: StreamBuilder<LatLng>(
              stream: trackDriverLocation(driverId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print(driverId);
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('خطأ في تحميل موقع السائق'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('لا يوجد موقع متاح'));
                }

                final driverLocation = snapshot.data!;

                if (_mapController != null) {
                  _mapController!.animateCamera(
                    CameraUpdate.newLatLng(driverLocation),
                  );
                }

                _lastLocation ??= driverLocation;

                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _lastLocation!,
                    zoom: 15,
                  ),
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('driver'),
                      position: driverLocation,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue,
                      ),
                    ),
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('إغلاق'),
            ),
          ],
        );
      },
    );
  }
