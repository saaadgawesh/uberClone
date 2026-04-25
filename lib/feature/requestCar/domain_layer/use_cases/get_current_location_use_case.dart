import 'package:injectable/injectable.dart';

import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/current_location_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/repository/request_car_repository.dart';

@injectable
class GetCurrentLocationUseCase {
  final RequestCarRepository repository;

  GetCurrentLocationUseCase(this.repository);

  Future<CurrentLocationEntity> call() {
    return repository.getCurrentLocation();
  }
}
