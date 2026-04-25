import 'package:injectable/injectable.dart';

import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/route_info_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/repository/request_car_repository.dart';

@injectable
class FetchRouteUseCase {
  final RequestCarRepository repository;

  FetchRouteUseCase(this.repository);

  Future<RouteInfoEntity> call(
    LocationPointEntity start,
    LocationPointEntity end,
  ) {
    return repository.fetchRoute(start, end);
  }
}
