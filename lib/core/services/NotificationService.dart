import '../../core/App_Imports/app_imports.dart';

enum UserRole { rider, driver }

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  UserRole currentRole = UserRole.rider;
  String? _userCollection;
  GlobalKey<NavigatorState>? _navigatorKey;

  void setUserRole(UserRole role) {
    currentRole = role;
  }

  void setUserCollection(String collection) {
    _userCollection = collection;
    if (_initialized) {
      _syncCurrentToken();
    }
  }

  void setNavigatorKey(GlobalKey<NavigatorState> navigatorKey) {
    _navigatorKey = navigatorKey;
  }

  Future<void> init() async {
    if (_initialized) return;

    await FirebaseMessaging.instance.requestPermission();
    await _syncCurrentToken();
    FirebaseMessaging.instance.onTokenRefresh.listen(_saveTokenToFirestore);

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _local.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        final tripId = details.payload;
        if (tripId != null) {
          handleNavigation(tripId);
        }
      },
    );

    FirebaseMessaging.onMessage.listen(handleForegroundFCM);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final tripId = message.data['tripId'] ?? '';
      handleNavigation(tripId);
    });

    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      final tripId = message.data['tripId'] ?? '';
      handleNavigation(tripId);
    }

    _initialized = true;
  }

  void handleForegroundFCM(RemoteMessage message) {
    final data = message.data;
    final type = data['type'] ?? '';
    final tripId = data['tripId'] ?? '';

    if (!_shouldReceive(type)) return;

    final content = _mapNotificationContent(type);
    showNotification(
      title: content.$1,
      body: content.$2,
      payload: tripId,
    );
  }

  bool _shouldReceive(String type) {
    if (currentRole == UserRole.driver) {
      return {
        'new_trip',
        'trip_cancelled',
        'payment_created',
      }.contains(type);
    }

    return {
      'trip_accepted',
      'driver_rejected',
      'trip_cancelled',
      'no_driver',
      'trip_completed',
      'payment_created',
    }.contains(type);
  }

  (String, String) _mapNotificationContent(String type) {
    switch (type) {
      case 'new_trip':
        return ('رحلة جديدة', 'تم توجيه رحلة جديدة إلى السائق');
      case 'trip_accepted':
        return ('تم قبول الرحلة', 'السائق وافق على الرحلة');
      case 'driver_rejected':
        return ('تم رفض الرحلة', 'جارٍ البحث عن سائق آخر');
      case 'trip_cancelled':
        return ('تم إلغاء الرحلة', 'تم إلغاء الرحلة الحالية');
      case 'no_driver':
        return ('لا يوجد سائق', 'لم يتم العثور على سائق متاح الآن');
      case 'trip_completed':
        return ('انتهت الرحلة', 'تم إنهاء الرحلة بنجاح');
      case 'payment_created':
        return ('تحديث دفع', 'تم إنشاء عملية دفع مرتبطة بالرحلة');
      default:
        return ('إشعار جديد', 'هناك تحديث جديد على الرحلة');
    }
  }

  void listenToDriverTrips(String driverId) {
    FirebaseFirestore.instance
        .collection('trips')
        .where('driverId', isEqualTo: driverId)
        .snapshots()
        .listen((snapshot) {
          for (final change in snapshot.docChanges) {
            if (change.type != DocumentChangeType.added) continue;
            final trip = change.doc.data();
            if (trip == null) continue;

            final riderName = (trip['riderName'] ?? 'راكب جديد').toString();
            showNotification(
              title: 'رحلة جديدة',
              body: '$riderName بحاجة إلى مشوار',
              payload: change.doc.id,
            );
          }
        });
  }

  Future<void> showNotification({
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

  void handleNavigation(String tripId) {
    if (tripId.isEmpty) return;

    final navigatorState = _navigatorKey?.currentState;
    if (navigatorState == null) return;

    navigatorState.pushNamed(Routes.myrequests);
  }

  Future<void> _syncCurrentToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await _saveTokenToFirestore(token);
    }
  }

  Future<void> _saveTokenToFirestore(String token) async {
    final user = FirebaseAuth.instance.currentUser;
    final collection = _userCollection;

    if (user == null || collection == null) return;

    await FirebaseFirestore.instance.collection(collection).doc(user.uid).set({
      'fcmToken': token,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
