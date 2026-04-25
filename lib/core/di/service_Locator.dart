import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:uberCloneRider/core/database/shared_pref_helper.dart';
import 'package:uberCloneRider/core/di/service_Locator.config.dart';
import 'package:uberCloneRider/feature/Location/Location_Controller/Location_Manager.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/Repositoryimpl/Auth_Repository_impl.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/UserCases/LoginUser.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/UserCases/LogoutUser.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/UserCases/RegisterUser.dart';
import 'package:uberCloneRider/feature/Auth/dataLayer/repository/AuthRepository.dart';
import 'package:uberCloneRider/feature/Auth/presentation/Cubit/Auth_Cubit.dart';
import 'package:uberCloneRider/feature/requestCar/api_client_layer/places_api_client.dart';
import 'package:uberCloneRider/feature/requestCar/api_client_layer/routing_api_client.dart';
import 'package:uberCloneRider/feature/requestCar/data_layer/repository/request_car_repository_impl.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/repository/request_car_repository.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/use_cases/fetch_route_use_case.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/use_cases/get_current_location_use_case.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/use_cases/search_places_use_case.dart';
import 'package:uberCloneRider/feature/requestCar/presentation/cubit/request_car_cubit.dart';

final servicelocator = GetIt.instance;
final _registerModule = _RegisterModule();

@InjectableInit()
void serviceLocatorConfiguration() {
  servicelocator.init();
  // Manual registrations since injectable is not generating
  if (!servicelocator.isRegistered<LocationManager>()) {
    servicelocator.registerLazySingleton<LocationManager>(() => LocationManager());
  }

  servicelocator
      .registerLazySingleton<Authrepository>(() => AuthRepositoryImpl());
  servicelocator.registerLazySingleton(
      () => Registeruser(servicelocator<Authrepository>()));
  servicelocator
      .registerLazySingleton(() => Loginuser(servicelocator<Authrepository>()));
  servicelocator.registerLazySingleton(
      () => Logoutuser(servicelocator<Authrepository>()));
  servicelocator.registerLazySingleton(() => AuthCubit(
        servicelocator<Registeruser>(),
        servicelocator<Loginuser>(),
        servicelocator<Logoutuser>(),
      ));

  if (!servicelocator.isRegistered<Dio>(instanceName: 'nominatim_dio')) {
    servicelocator.registerLazySingleton<Dio>(
      () => _registerModule.nominatimDio,
      instanceName: 'nominatim_dio',
    );
  }

  if (!servicelocator.isRegistered<Dio>(instanceName: 'osrm_dio')) {
    servicelocator.registerLazySingleton<Dio>(
      () => _registerModule.osrmDio,
      instanceName: 'osrm_dio',
    );
  }

  if (!servicelocator.isRegistered<PlacesApiClient>()) {
    servicelocator.registerLazySingleton<PlacesApiClient>(
      () => PlacesApiClient(
        servicelocator<Dio>(instanceName: 'nominatim_dio'),
      ),
    );
  }

  if (!servicelocator.isRegistered<RoutingApiClient>()) {
    servicelocator.registerLazySingleton<RoutingApiClient>(
      () => RoutingApiClient(
        servicelocator<Dio>(instanceName: 'osrm_dio'),
      ),
    );
  }

  if (!servicelocator.isRegistered<RequestCarRepository>()) {
    servicelocator.registerLazySingleton<RequestCarRepository>(
      () => RequestCarRepositoryImpl(
        servicelocator<PlacesApiClient>(),
        servicelocator<RoutingApiClient>(),
        servicelocator<LocationManager>(),
      ),
    );
  }

  if (!servicelocator.isRegistered<GetCurrentLocationUseCase>()) {
    servicelocator.registerLazySingleton(
      () => GetCurrentLocationUseCase(servicelocator<RequestCarRepository>()),
    );
  }

  if (!servicelocator.isRegistered<SearchPlacesUseCase>()) {
    servicelocator.registerLazySingleton(
      () => SearchPlacesUseCase(servicelocator<RequestCarRepository>()),
    );
  }

  if (!servicelocator.isRegistered<FetchRouteUseCase>()) {
    servicelocator.registerLazySingleton(
      () => FetchRouteUseCase(servicelocator<RequestCarRepository>()),
    );
  }

  if (!servicelocator.isRegistered<RequestCarCubit>()) {
    servicelocator.registerFactory(
      () => RequestCarCubit(
        servicelocator<GetCurrentLocationUseCase>(),
        servicelocator<SearchPlacesUseCase>(),
        servicelocator<FetchRouteUseCase>(),
      ),
    );
  }
}

@module
abstract class RegisterModule {
  @singleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://round8-cure-php-team-two.huma-volve.com/api/v1/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // final sharedPref = await SharedPreferences.getInstance();
          final token = SharedPrefHelper.getString('user_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          // options.headers['Content-Type'] = 'application/json';
          // options.headers['Accept'] = 'application/json';

          handler.next(options); // لازم في جميع الحالات
        },
      ),
    );
    return dio;
  }

  @Named('nominatim_dio')
  @lazySingleton
  Dio get nominatimDio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://nominatim.openstreetmap.org',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'UberCloneRider/1.0 (com.example.uber)',
        },
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: false,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    return dio;
  }

  @Named('osrm_dio')
  @lazySingleton
  Dio get osrmDio {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://router.project-osrm.org',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Accept': 'application/json',
          'User-Agent': 'UberCloneRider/1.0 (com.example.uber)',
        },
      ),
    );
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: false,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    return dio;
  }
}

class _RegisterModule extends RegisterModule {}
