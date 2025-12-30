class ApiConstant {
  static const String _apiKey = '9oUhV5iH4jAG46lvltNN';

  /// Search places
  String searchPlace(String place) {
    final encodedPlace = Uri.encodeComponent(place);
    return 'https://api.maptiler.com/geocoding/$encodedPlace.json?key=$_apiKey';
  }

  /// Map tiles
  String mapTileUrl =
      'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=$_apiKey';
}
