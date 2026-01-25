
import '../../core/App_Imports/app_imports.dart';

class LocalTripNotificationService {
  // Singleton instance
  static final LocalTripNotificationService _instance =
      LocalTripNotificationService._internal();
  factory LocalTripNotificationService() => _instance;
  LocalTripNotificationService._internal();

  // Flutter local notifications plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Call this once in main() before running the app
  Future<void> init() async {
    if (_initialized) return;

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    _initialized = true;
  }

  /// Listen to trips for the given driverId and show local notifications
  void listenToTrips({required String driverId}) {
    FirebaseFirestore.instance
        .collection('trips')
        .where('driverId', isEqualTo: driverId)
        .snapshots()
        .listen((snapshot) {
          for (var docChange in snapshot.docChanges) {
            if (docChange.type == DocumentChangeType.added) {
              final trip = docChange.doc.data();
              if (trip != null) {
                // Optional: get rider name from trip data
                final riderName = trip['riderName'] ?? 'راكب جديد';
                showLocalNotification(
                  title: '🚗 رحلة جديدة',
                  body: '$riderName بحاجة لمشوار',
                );
              }
            }
          }
        });
  }

  /// Show a local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'trips_channel_id',
          'Trips Notifications',
          channelDescription: 'Notifications for new trips',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformDetails,
    );
  }
}
