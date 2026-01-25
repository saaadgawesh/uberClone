import '../../core/App_Imports/app_imports.dart';

enum UserRole { rider, driver }

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
//
  bool _initialized = false;

  UserRole currentRole = UserRole.rider; // قيمة افتراضية

  void setUserRole(UserRole role) {
    currentRole = role;
  }

  /// ----------------------------------------
  /// INITIALIZE
  /// ----------------------------------------
  Future<void> init() async {
    if (_initialized) return;

    await FirebaseMessaging.instance.requestPermission();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _local.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        final tripId = details.payload;
        if (tripId != null) {
          _handleNavigation(tripId);
        }
      },
    );

    FirebaseMessaging.onMessage.listen(_handleForegroundFCM);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final tripId = message.data['tripId'] ?? '';
      _handleNavigation(tripId);
    });

    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      final tripId = message.data['tripId'] ?? '';
      _handleNavigation(tripId);
    }

    _initialized = true;
  }

  /// ----------------------------------------
  /// FOREGROUND FCM
  /// ----------------------------------------
  void _handleForegroundFCM(RemoteMessage message) {
    final data = message.data;
    final type = data['type'] ?? '';
    final tripId = data['tripId'] ?? '';

    if (!_shouldReceive(type)) return;

    String title = 'إشعار جديد';
    String body = '';

    switch (type) {
      case 'new_trip':
        title = '🚕 رحلة جديدة';
        body = 'يوجد رحلة جديدة متاحة';
        break;
      case 'trip_accepted':
        title = '✅ تم قبول الرحلة';
        body = 'السائق وافق على الرحلة';
        break;
      case 'driver_rejected':
        title = '🚗 تم رفض الرحلة';
        body = 'نبحث عن سائق قريب';
        break;
      case 'trip_cancelled':
        title = '❌ تم إلغاء الرحلة';
        body = 'تم إلغاء الرحلة';
        break;
    }

    _showNotification(title: title, body: body, payload: tripId);
  }

  /// ----------------------------------------
  /// FILTER BY ROLE
  /// ----------------------------------------
  bool _shouldReceive(String type) {
    if (currentRole == UserRole.driver) {
      return type == 'new_trip' || type == 'trip_cancelled';
    }

    if (currentRole == UserRole.rider) {
      return type == 'trip_accepted' ||
          type == 'driver_rejected' ||
          type == 'trip_cancelled';
    }

    return false;
  }

  /// ----------------------------------------
  /// FIRESTORE LISTENER
  /// ----------------------------------------
  void listenToDriverTrips(String driverId) {
    FirebaseFirestore.instance
        .collection('trips')
        .where('driverId', isEqualTo: driverId)
        .snapshots()
        .listen((snapshot) {
          for (var change in snapshot.docChanges) {
            if (change.type == DocumentChangeType.added) {
              final trip = change.doc.data();
              if (trip != null) {
                final riderName = trip['riderName'] ?? 'راكب جديد';
                _showNotification(
                  title: '🚗 رحلة جديدة',
                  body: '$riderName بحاجة لمشوار',
                  payload: change.doc.id,
                );
              }
            }
          }
        });
  }

  /// ----------------------------------------
  /// SHOW LOCAL
  /// ----------------------------------------
  Future<void> _showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'trips_channel_id',
      'Trips Notifications',
      channelDescription: 'Notifications for trips',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// ----------------------------------------
  /// NAVIGATION
  /// ----------------------------------------
  void _handleNavigation(String tripId) {
    if (tripId.isEmpty) return;

    print('Navigate to trip page: $tripId');

    // حسب الدور:
    // if (currentRole == UserRole.driver) { ... }
    // else { ... }
  }
}
