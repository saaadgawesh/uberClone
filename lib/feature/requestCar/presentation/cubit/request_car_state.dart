import 'package:equatable/equatable.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/place_suggestion_entity.dart';

class RequestCarState extends Equatable {
  final bool isInitializing;
  final bool isSearching;
  final bool isFetchingRoute;
  final bool showResults;
  final bool isSearchingForDeparture;
  final LocationPointEntity? currentLocation;
  final LocationPointEntity? departureLocation;
  final LocationPointEntity? returnLocation;
  final String? currentAddress;
  final String? departureAddress;
  final String? returnAddress;
  final List<LocationPointEntity> routePoints;
  final List<PlaceSuggestionEntity> searchResults;
  final double? tripDistanceKm;
  final double? tripDurationMin;
  final String? message;

  const RequestCarState({
    this.isInitializing = false,
    this.isSearching = false,
    this.isFetchingRoute = false,
    this.showResults = false,
    this.isSearchingForDeparture = true,
    this.currentLocation,
    this.departureLocation,
    this.returnLocation,
    this.currentAddress,
    this.departureAddress,
    this.returnAddress,
    this.routePoints = const [],
    this.searchResults = const [],
    this.tripDistanceKm,
    this.tripDurationMin,
    this.message,
  });

  RequestCarState copyWith({
    bool? isInitializing,
    bool? isSearching,
    bool? isFetchingRoute,
    bool? showResults,
    bool? isSearchingForDeparture,
    LocationPointEntity? currentLocation,
    LocationPointEntity? departureLocation,
    LocationPointEntity? returnLocation,
    String? currentAddress,
    String? departureAddress,
    String? returnAddress,
    List<LocationPointEntity>? routePoints,
    List<PlaceSuggestionEntity>? searchResults,
    double? tripDistanceKm,
    double? tripDurationMin,
    String? message,
    bool clearMessage = false,
  }) {
    return RequestCarState(
      isInitializing: isInitializing ?? this.isInitializing,
      isSearching: isSearching ?? this.isSearching,
      isFetchingRoute: isFetchingRoute ?? this.isFetchingRoute,
      showResults: showResults ?? this.showResults,
      isSearchingForDeparture:
          isSearchingForDeparture ?? this.isSearchingForDeparture,
      currentLocation: currentLocation ?? this.currentLocation,
      departureLocation: departureLocation ?? this.departureLocation,
      returnLocation: returnLocation ?? this.returnLocation,
      currentAddress: currentAddress ?? this.currentAddress,
      departureAddress: departureAddress ?? this.departureAddress,
      returnAddress: returnAddress ?? this.returnAddress,
      routePoints: routePoints ?? this.routePoints,
      searchResults: searchResults ?? this.searchResults,
      tripDistanceKm: tripDistanceKm ?? this.tripDistanceKm,
      tripDurationMin: tripDurationMin ?? this.tripDurationMin,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [
        isInitializing,
        isSearching,
        isFetchingRoute,
        showResults,
        isSearchingForDeparture,
        currentLocation,
        departureLocation,
        returnLocation,
        currentAddress,
        departureAddress,
        returnAddress,
        routePoints,
        searchResults,
        tripDistanceKm,
        tripDurationMin,
        message,
      ];
}
