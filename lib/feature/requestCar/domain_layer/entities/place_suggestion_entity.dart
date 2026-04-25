import 'package:equatable/equatable.dart';

import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';

class PlaceSuggestionEntity extends Equatable {
  final String displayName;
  final LocationPointEntity location;

  const PlaceSuggestionEntity({
    required this.displayName,
    required this.location,
  });

  @override
  List<Object> get props => [displayName, location];
}
