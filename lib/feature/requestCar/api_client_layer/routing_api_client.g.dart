// GENERATED CODE - MANUAL STUB

part of 'routing_api_client.dart';

class _RoutingApiClient implements RoutingApiClient {
  _RoutingApiClient(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Map<String, dynamic>> fetchRoute({
    required String coordinates,
    String overview = 'full',
    String geometries = 'polyline',
  }) async {
    final queryParameters = <String, dynamic>{
      'overview': overview,
      'geometries': geometries,
    };

    final result = await _dio.fetch<Map<String, dynamic>>(
      _setStreamType<Map<String, dynamic>>(
        Options(method: 'GET').compose(
          _dio.options,
          '/route/v1/driving/$coordinates',
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
