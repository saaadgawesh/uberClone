import 'package:equatable/equatable.dart';

import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';

class RouteInfoEntity extends Equatable {
  final double distanceKm;
  final double durationMin;
  final List<LocationPointEntity> points;
  final bool isFallback;

  const RouteInfoEntity({
    required this.distanceKm,
    required this.durationMin,
    required this.points,
    this.isFallback = false,
  });

  @override
  List<Object> get props => [distanceKm, durationMin, points, isFallback];
}
