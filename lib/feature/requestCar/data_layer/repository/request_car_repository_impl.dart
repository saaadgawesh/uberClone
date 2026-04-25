import 'package:injectable/injectable.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:uberCloneRider/feature/Location/Location_Controller/Location_Manager.dart';
import 'package:uberCloneRider/feature/requestCar/api_client_layer/places_api_client.dart';
import 'package:uberCloneRider/feature/requestCar/api_client_layer/routing_api_client.dart';
import 'package:uberCloneRider/feature/requestCar/data_layer/models/place_suggestion_model.dart';
import 'package:uberCloneRider/feature/requestCar/data_layer/models/route_info_model.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/current_location_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/place_suggestion_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/route_info_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/repository/request_car_repository.dart';

@LazySingleton(as: RequestCarRepository)
class RequestCarRepositoryImpl implements RequestCarRepository {
  RequestCarRepositoryImpl(
    this._placesApiClient,
    this._routingApiClient,
    this._locationManager,
  );

  static const LocationPointEntity _defaultLocation = LocationPointEntity(
    latitude: 30.0444,
    longitude: 31.2357,
  );
  static const String _defaultAddress = 'Cairo, Egypt';

  final PlacesApiClient _placesApiClient;
  final RoutingApiClient _routingApiClient;
  final LocationManager _locationManager;

  @override
  Future<CurrentLocationEntity> getCurrentLocation() async {
    final locationData = await _locationManager.getUserLocation();
    if (!_hasValidCoordinates(locationData)) {
      return const CurrentLocationEntity(
        location: _defaultLocation,
        address: _defaultAddress,
        isFallback: true,
      );
    }

    final location = LocationPointEntity(
      latitude: locationData!.latitude!,
      longitude: locationData.longitude!,
    );

    try {
      final response = await _placesApiClient.reverseGeocode(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      final address = response['display_name'] as String? ?? _defaultAddress;
      return CurrentLocationEntity(location: location, address: address);
    } catch (_) {
      return CurrentLocationEntity(location: location, address: _defaultAddress);
    }
  }

  @override
  Future<List<PlaceSuggestionEntity>> searchPlaces(String query) async {
    try {
      final response = await _placesApiClient.searchPlaces(query: query);
      return response
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .map(PlaceSuggestionModel.fromMap)
          .where((place) => place.displayName.isNotEmpty)
          .toList();
    } catch (_) {
      return <PlaceSuggestionEntity>[];
    }
  }

  @override
  Future<RouteInfoEntity> fetchRoute(
    LocationPointEntity start,
    LocationPointEntity end,
  ) async {
    try {
      final response = await _routingApiClient.fetchRoute(
        coordinates:
            '${start.longitude},${start.latitude};${end.longitude},${end.latitude}',
      );
      final routes = response['routes'];

      if (response['code'] != 'Ok' || routes is! List || routes.isEmpty) {
        return _fallbackRoute(start, end);
      }

      return RouteInfoModel.fromOsrmMap(
        Map<String, dynamic>.from(routes.first as Map),
      );
    } catch (_) {
      return _fallbackRoute(start, end);
    }
  }

  bool _hasValidCoordinates(LocationData? locationData) {
    final latitude = locationData?.latitude;
    final longitude = locationData?.longitude;

    if (latitude == null || longitude == null) return false;
    if (latitude == 0 && longitude == 0) return false;

    return true;
  }

  RouteInfoEntity _fallbackRoute(
    LocationPointEntity start,
    LocationPointEntity end,
  ) {
    final distanceKm = const Distance().as(
      LengthUnit.Kilometer,
      start.toLatLng(),
      end.toLatLng(),
    );
    final durationMin = ((distanceKm / 35) * 60).clamp(1, 180).toDouble();

    return RouteInfoEntity(
      distanceKm: distanceKm,
      durationMin: durationMin,
      points: [start, end],
      isFallback: true,
    );
  }
}
