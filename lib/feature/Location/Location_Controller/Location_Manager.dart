import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class LocationManager {
  final Location _location = Location();
  Stream<LocationData>? _locationStream;

  /// طلب صلاحيات الوصول للموقع
  Future<bool> _requestPermission() async {
    final permission = await _location.requestPermission();
    return permission == PermissionStatus.granted;
  }

  /// التحقق من خدمة الموقع
  Future<bool> _requestService() async {
    final serviceEnabled = await _location.requestService();
    return serviceEnabled;
  }

  /// الحصول على الموقع الحالي مرة واحدة
  Future<LocationData?> getUserLocation() async {
    final hasPermission = await _requestPermission();
    final serviceEnabled = await _requestService();

    if (!hasPermission || !serviceEnabled) {
      return null;
    }

    return await _location.getLocation();
  }

  /// بدء تتبع الموقع بشكل مستمر
  void startTracking(void Function(LatLng) onLocationUpdate) async {
    final hasPermission = await _requestPermission();
    final serviceEnabled = await _requestService();

    if (!hasPermission || !serviceEnabled) return;

    _location.changeSettings(
      interval: 3000, // تحديث كل 3 ثواني
      distanceFilter: 5, // فقط إذا تحرك 5 متر أو أكثر
    );

    _locationStream = _location.onLocationChanged;
    _locationStream!.listen((locationData) {
      final latLng = LatLng(locationData.latitude!, locationData.longitude!);
      onLocationUpdate(latLng);
    });
  }

  /// إيقاف تتبع الموقع
  void stopTracking() {
    _locationStream = null;
  }
}
