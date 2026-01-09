import 'package:location/location.dart';

class LocationManager {
  final Location _location = Location();

  Future<bool> _requestPermission() async {
    final permission = await _location.requestPermission();
    return permission == PermissionStatus.granted;
  }

  Future<bool> _requestService() async {
    final serviceEnabled = await _location.requestService();
    return serviceEnabled;
  }

  Future<LocationData?> getUserLocation() async {
    final hasPermission = await _requestPermission();
    final serviceEnabled = await _requestService();

    if (!hasPermission || !serviceEnabled) {
      return null;
    }

    return await _location.getLocation();
  }
}
