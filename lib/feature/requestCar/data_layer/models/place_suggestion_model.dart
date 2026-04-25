import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/place_suggestion_entity.dart';

class PlaceSuggestionModel extends PlaceSuggestionEntity {
  const PlaceSuggestionModel({
    required super.displayName,
    required super.location,
  });

  factory PlaceSuggestionModel.fromMap(Map<String, dynamic> map) {
    return PlaceSuggestionModel(
      displayName: map['display_name'] as String? ?? '',
      location: LocationPointEntity(
        latitude: double.tryParse('${map['lat']}') ?? 0,
        longitude: double.tryParse('${map['lon']}') ?? 0,
      ),
    );
  }
}
