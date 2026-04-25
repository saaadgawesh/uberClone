import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'routing_api_client.g.dart';

@RestApi()
abstract class RoutingApiClient {
  factory RoutingApiClient(Dio dio, {String baseUrl}) = _RoutingApiClient;

  @GET('/route/v1/driving/{coordinates}')
  Future<Map<String, dynamic>> fetchRoute({
    @Path('coordinates') required String coordinates,
    @Query('overview') String overview = 'full',
    @Query('geometries') String geometries = 'polyline',
  });
}
