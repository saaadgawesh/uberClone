import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'places_api_client.g.dart';

@RestApi()
abstract class PlacesApiClient {
  factory PlacesApiClient(Dio dio, {String baseUrl}) = _PlacesApiClient;

  @GET('/search')
  Future<List<dynamic>> searchPlaces({
    @Query('q') required String query,
    @Query('format') String format = 'json',
    @Query('limit') int limit = 5,
    @Query('countrycodes') String countryCodes = 'eg',
    @Query('accept-language') String language = 'ar,en',
    @Query('addressdetails') int addressDetails = 1,
  });

  @GET('/reverse')
  Future<Map<String, dynamic>> reverseGeocode({
    @Query('lat') required double latitude,
    @Query('lon') required double longitude,
    @Query('format') String format = 'json',
    @Query('accept-language') String language = 'ar,en',
  });
}
