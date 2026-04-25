// GENERATED CODE - MANUAL STUB

part of 'places_api_client.dart';

class _PlacesApiClient implements PlacesApiClient {
  _PlacesApiClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<dynamic>> searchPlaces({
    required String query,
    String format = 'json',
    int limit = 5,
    String countryCodes = 'eg',
    String language = 'ar,en',
    int addressDetails = 1,
  }) async {
    final queryParameters = <String, dynamic>{
      'q': query,
      'format': format,
      'limit': limit,
      'countrycodes': countryCodes,
      'accept-language': language,
      'addressdetails': addressDetails,
    };

    final result = await _dio.fetch<List<dynamic>>(
      _setStreamType<List<dynamic>>(
        Options(method: 'GET').compose(
          _dio.options,
          '/search',
          queryParameters: queryParameters,
        ).copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );

    return result.data ?? <dynamic>[];
  }

  @override
  Future<Map<String, dynamic>> reverseGeocode({
    required double latitude,
    required double longitude,
    String format = 'json',
    String language = 'ar,en',
  }) async {
    final queryParameters = <String, dynamic>{
      'lat': latitude,
      'lon': longitude,
      'format': format,
      'accept-language': language,
    };

    final result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<Map<String, dynamic>>(
        Options(method: 'GET').compose(
          _dio.options,
          '/reverse',
          queryParameters: queryParameters,
        ).copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl),
      ),
    );

    return result.data ?? <String, dynamic>{};
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
