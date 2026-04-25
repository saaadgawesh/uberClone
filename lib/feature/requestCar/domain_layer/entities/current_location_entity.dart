import 'package:equatable/equatable.dart';

import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';

class CurrentLocationEntity extends Equatable {
  final LocationPointEntity location;
  final String address;
  final bool isFallback;

  const CurrentLocationEntity({
    required this.location,
    required this.address,
    this.isFallback = false,
  });

  @override
  List<Object> get props => [location, address, isFallback];
}
