// import 'package:url_launcher/url_launcher.dart';

// Future<void> openRouteInGoogleMaps({
//   required double fromLat,
//   required double fromLng,
//   required double toLat,
//   required double toLng,
// }) async {
//   final url =
//       'https://www.google.com/maps/dir/?api=1&origin=$fromLat,$fromLng&destination=$toLat,$toLng&travelmode=driving';

//   final uri = Uri.parse(url);

//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     throw 'Could not open Google Maps';
//   }
// }
import 'package:url_launcher/url_launcher.dart';

Future<void> openRouteInGoogleMaps({
  required double fromLat,
  required double fromLng,
  required double toLat,
  required double toLng,
}) async {
  final url =
      'https://www.google.com/maps/dir/?api=1&origin=$fromLat,$fromLng&destination=$toLat,$toLng&travelmode=driving';
  final uri = Uri.parse(url);

  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    print('Could not open Google Maps: $e');
  }
}
