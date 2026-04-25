import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:uberCloneRider/core/App_Imports/app_imports.dart';
import 'package:uberCloneRider/core/widgets/AppscaffoldMessanger.dart';
import 'package:uberCloneRider/feature/requestCar/presentation/cubit/request_car_cubit.dart';
import 'package:uberCloneRider/feature/requestCar/presentation/cubit/request_car_state.dart';

class RequestCarView extends StatefulWidget {
  const RequestCarView({super.key});

  @override
  State<RequestCarView> createState() => _RequestCarViewState();
}

class _RequestCarViewState extends State<RequestCarView> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _returnController = TextEditingController();
  late final MapController _mapController;
  bool _isMapReady = false;

  final double _baseFare = 10;
  final double _pricePerKm = 5;
  final double _pricePerMin = 1;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _departureController.dispose();
    _returnController.dispose();
    super.dispose();
  }

  double _calculatePrice(RequestCarState state) {
    if (state.tripDistanceKm == null || state.tripDurationMin == null) return 0;
    final total = _baseFare +
        (state.tripDistanceKm! * _pricePerKm) +
        (state.tripDurationMin! * _pricePerMin);
    return total.clamp(20, 500);
  }

  void _syncControllers(RequestCarState state) {
    if (state.departureAddress != null &&
        _departureController.text != state.departureAddress) {
      _departureController.text = state.departureAddress!;
    }
    if (state.returnAddress != null &&
        _returnController.text != state.returnAddress) {
      _returnController.text = state.returnAddress!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;

    return BlocConsumer<RequestCarCubit, RequestCarState>(
      listenWhen: (previous, current) =>
          previous.message != current.message ||
          previous.currentLocation != current.currentLocation ||
          previous.departureLocation != current.departureLocation ||
          previous.returnLocation != current.returnLocation,
      listener: (context, state) {
        _syncControllers(state);

        final targetLocation = state.returnLocation ??
            state.departureLocation ??
            state.currentLocation;
        if (_isMapReady && targetLocation != null) {
          _mapController.move(targetLocation.toLatLng(), 15);
        }

        if (state.message != null && state.message!.isNotEmpty) {
          AppScaffoldMessanger(context, state.message!);
          context.read<RequestCarCubit>().clearMessage();
        }
      },
      builder: (context, state) {
        final cubit = context.read<RequestCarCubit>();
        final currentCenter =
            state.currentLocation?.toLatLng() ?? const LatLng(30.0444, 31.2357);

        return Scaffold(
          body: Stack(
            children: [
              state.isInitializing
                  ? Center(
                      child: CircularProgressIndicator(color: context.bgColor),
                    )
                  : FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: currentCenter,
                        initialZoom: 13,
                        onMapReady: () {
                          _isMapReady = true;
                          final targetLocation = state.returnLocation ??
                              state.departureLocation ??
                              state.currentLocation;
                          if (targetLocation != null) {
                            _mapController.move(targetLocation.toLatLng(), 15);
                          }
                        },
                        interactionOptions: const InteractionOptions(
                          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                        ),
                        onTap: (_, __) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
                          subdomains: const ['a', 'b', 'c'],
                          tileProvider: NetworkTileProvider(
                            headers: {
                              'User-Agent': 'UberCloneRider/1.0 (com.example.uber)',
                            },
                          ),
                        ),
                        if (state.departureLocation != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: state.departureLocation!.toLatLng(),
                                width: 35,
                                height: 35,
                                child: customAppIcon(
                                  iconName: Icons.location_on,
                                  iconColor: AppColors.blueColor,
                                ),
                              ),
                            ],
                          ),
                        if (state.returnLocation != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: state.returnLocation!.toLatLng(),
                                width: 35,
                                height: 35,
                                child: customAppIcon(
                                  iconName: Icons.location_pin,
                                  iconColor: AppColors.redColor,
                                ),
                              ),
                            ],
                          ),
                        if (state.routePoints.isNotEmpty)
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: state.routePoints
                                    .map((point) => point.toLatLng())
                                    .toList(),
                                strokeWidth: 5,
                                color: AppColors.redColor,
                              ),
                            ],
                          ),
                      ],
                    ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppTextField(
                        keyboardType: TextInputType.text,
                        controller: _departureController,
                        hintText: 'Departure location',
                        onChange: (value) => cubit.onSearchChanged(
                          value,
                          forDeparture: true,
                        ),
                        onFieldSubmitted: (value) => cubit.searchPlaces(
                          value,
                          forDeparture: true,
                        ),
                        prefix: IconButton(
                          icon: customAppIcon(
                            iconName: Icons.my_location,
                            iconColor: context.bgColor,
                          ),
                          onPressed: cubit.setDepartureToCurrentLocation,
                        ),
                        suffix: IconButton(
                          icon: state.isSearching &&
                                  state.isSearchingForDeparture
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : customAppIcon(
                                  iconName: Icons.search,
                                  iconColor: context.bgColor,
                                ),
                          onPressed: () => cubit.searchPlaces(
                            _departureController.text,
                            forDeparture: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppTextField(
                        keyboardType: TextInputType.text,
                        controller: _returnController,
                        hintText: 'Return location',
                        onChange: (value) => cubit.onSearchChanged(
                          value,
                          forDeparture: false,
                        ),
                        onFieldSubmitted: (value) => cubit.searchPlaces(
                          value,
                          forDeparture: false,
                        ),
                        suffix: IconButton(
                          icon: state.isSearching &&
                                  !state.isSearchingForDeparture
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : customAppIcon(
                                  iconName: Icons.search,
                                  iconColor: context.bgColor,
                                ),
                          onPressed: () => cubit.searchPlaces(
                            _returnController.text,
                            forDeparture: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state.showResults)
                Positioned(
                  top: appHeight(context) * 0.14,
                  left: 16,
                  right: 16,
                  child: Material(
                    elevation: 8,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: appHeight(context) * 0.35,
                      ),
                      child: state.isSearching
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(24),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : state.searchResults.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text('No places found for this search'),
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.searchResults.length,
                                  itemBuilder: (_, index) {
                                    final place = state.searchResults[index];
                                    return ListTile(
                                      title: Text(place.displayName),
                                      onTap: () {
                                        cubit.selectPlace(place);
                                        _mapController.move(
                                          place.location.toLatLng(),
                                          15,
                                        );
                                      },
                                    );
                                  },
                                  separatorBuilder: (_, __) => AppDivider(),
                                ),
                    ),
                  ),
                ),
            ],
          ),
          floatingActionButton: defaultFloatingActionButton(
            onpressed: cubit.initializeLocation,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8),
            child: defaultElevatedButton(
              textbutton: state.isFetchingRoute
                  ? 'Loading route...'
                  : applocalization.confirmLocation,
              bgButtonColor: context.bgColor,
              width: appWidth(context) * 0.9,
              textcolor: AppColors.whiteColor,
              onPressed: () {
                if (state.currentLocation == null ||
                    state.departureLocation == null ||
                    state.returnLocation == null ||
                    state.tripDistanceKm == null ||
                    state.tripDurationMin == null) {
                  AppScaffoldMessanger(
                    context,
                    applocalization.selectDestinationfirst,
                  );
                  return;
                }

                final tripPreview = Tripmodel(
                  tripId: '',
                  riderId: FirebaseAuth.instance.currentUser!.uid,
                  driverId: '',
                  startLocation: state.departureLocation!.toLatLng(),
                  endLocation: state.returnLocation!.toLatLng(),
                  startAddress: state.departureAddress ?? 'Unknown Location',
                  endAddress: state.returnAddress ?? '',
                  distanceKm: state.tripDistanceKm!,
                  durationMin: state.tripDurationMin!,
                  price: _calculatePrice(state),
                  status: 'pending',
                  createdAt: DateTime.now(),
                  riderName: '',
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TripSummaryScreen(tripmodel: tripPreview),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
