import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/place_suggestion_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/use_cases/fetch_route_use_case.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/use_cases/get_current_location_use_case.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/use_cases/search_places_use_case.dart';
import 'package:uberCloneRider/feature/requestCar/presentation/cubit/request_car_state.dart';

@injectable
class RequestCarCubit extends Cubit<RequestCarState> {
  RequestCarCubit(
    this._getCurrentLocationUseCase,
    this._searchPlacesUseCase,
    this._fetchRouteUseCase,
  ) : super(const RequestCarState());

  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final SearchPlacesUseCase _searchPlacesUseCase;
  final FetchRouteUseCase _fetchRouteUseCase;

  Timer? _searchDebounce;

  Future<void> initializeLocation() async {
    emit(state.copyWith(isInitializing: true, clearMessage: true));
    final currentLocation = await _getCurrentLocationUseCase();

    emit(
      state.copyWith(
        isInitializing: false,
        currentLocation: currentLocation.location,
        currentAddress: currentLocation.address,
        departureLocation: currentLocation.location,
        departureAddress: currentLocation.address,
        message: currentLocation.isFallback
            ? 'تم ضبط الموقع الحالي على القاهرة مؤقتًا. حدّث لوكيشن الجهاز أو الإيموليتر لو عايز موقعك الحقيقي.'
            : null,
      ),
    );
  }

  void setDepartureToCurrentLocation() {
    if (state.currentLocation == null || state.currentAddress == null) return;

    emit(
      state.copyWith(
        departureLocation: state.currentLocation,
        departureAddress: state.currentAddress,
        showResults: false,
      ),
    );
    _fetchRouteIfPossible();
  }

  void onSearchChanged(String query, {required bool forDeparture}) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(
      const Duration(milliseconds: 500),
      () => searchPlaces(query, forDeparture: forDeparture),
    );
  }

  Future<void> searchPlaces(
    String query, {
    required bool forDeparture,
  }) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.length < 3) {
      emit(
        state.copyWith(
          showResults: false,
          searchResults: const [],
          isSearching: false,
          isSearchingForDeparture: forDeparture,
          clearMessage: true,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        isSearching: true,
        showResults: true,
        searchResults: const [],
        isSearchingForDeparture: forDeparture,
        clearMessage: true,
      ),
    );

    final places = await _searchPlacesUseCase(trimmedQuery);
    emit(
      state.copyWith(
        isSearching: false,
        showResults: true,
        searchResults: places,
        isSearchingForDeparture: forDeparture,
      ),
    );
  }

  Future<void> selectPlace(PlaceSuggestionEntity place) async {
    if (state.isSearchingForDeparture) {
      emit(
        state.copyWith(
          departureLocation: place.location,
          departureAddress: place.displayName,
          showResults: false,
          searchResults: const [],
          clearMessage: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          returnLocation: place.location,
          returnAddress: place.displayName,
          showResults: false,
          searchResults: const [],
          clearMessage: true,
        ),
      );
    }

    await _fetchRouteIfPossible();
  }

  Future<void> _fetchRouteIfPossible() async {
    if (state.departureLocation == null || state.returnLocation == null) return;

    emit(state.copyWith(isFetchingRoute: true, clearMessage: true));
    final route = await _fetchRouteUseCase(
      state.departureLocation!,
      state.returnLocation!,
    );

    emit(
      state.copyWith(
        isFetchingRoute: false,
        routePoints: route.points,
        tripDistanceKm: route.distanceKm,
        tripDurationMin: route.durationMin,
        message: route.isFallback
            ? 'تعذر تحميل الطريق من الخادم، فتم استخدام مسار تقريبي حسب موقعك الحالي.'
            : null,
      ),
    );
  }

  void clearMessage() {
    emit(state.copyWith(clearMessage: true));
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
