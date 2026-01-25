// import 'package:location/location.dart';

// class LocationManager {
//   final Location _location = Location();

//   Future<bool> _requestPermission() async {
//     final permission = await _location.requestPermission();
//     return permission == PermissionStatus.granted;
//   }

//   Future<bool> _requestService() async {
//     final serviceEnabled = await _location.requestService();
//     return serviceEnabled;
//   }

//   Future<LocationData?> getUserLocation() async {
//     final hasPermission = await _requestPermission();
//     final serviceEnabled = await _requestService();

//     if (!hasPermission || !serviceEnabled) {
//       return null;
//     }

//     return await _location.getLocation();
//   }
// }
import 'package:location/location.dart';

class LocationManager {
  final Location _location = Location();

  Future<LocationData?> getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // 1. Check service
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        print("GPS service not enabled");
        return null;
      }
    }

    // 2. Check permission
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        print("Location permission denied");
        return null;
      }
    }

    if (permissionGranted == PermissionStatus.deniedForever) {
      print("Permission denied forever");
      return null;
    }

    // 3. Get location
    final locationData = await _location.getLocation();
    return locationData;
  }
}
