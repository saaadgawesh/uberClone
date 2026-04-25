import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/current_location_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/place_suggestion_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/route_info_entity.dart';

abstract class RequestCarRepository {
  Future<CurrentLocationEntity> getCurrentLocation();
  Future<List<PlaceSuggestionEntity>> searchPlaces(String query);
  Future<RouteInfoEntity> fetchRoute(
    LocationPointEntity start,
    LocationPointEntity end,
  );
}
