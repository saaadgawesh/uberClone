import 'package:injectable/injectable.dart';

import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/place_suggestion_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/repository/request_car_repository.dart';

@injectable
class SearchPlacesUseCase {
  final RequestCarRepository repository;

  SearchPlacesUseCase(this.repository);

  Future<List<PlaceSuggestionEntity>> call(String query) {
    return repository.searchPlaces(query);
  }
}
