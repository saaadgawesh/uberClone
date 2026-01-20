import"../../../../core/App_Imports/app_imports.dart";
Future<void> sendToNextNearestDriver(
  String tripId,
  List<String> rejectedDrivers,
) async {
  final drivers = await FirebaseFirestore.instance
      .collection('Driver')
      .where('isOnline', isEqualTo: true)
      .where('status', isEqualTo: 'available')
      .get();

  for (var driver in drivers.docs) {
    if (rejectedDrivers.contains(driver.id)) continue;

    // تحديث الرحلة للسواق الجديد
    await FirebaseFirestore.instance.collection('trips').doc(tripId).update({
      'driverId': driver.id,
    });

    // إشعار السواق الجديد محليًا
    NotificationService().showNotification(
      title: '🚕 رحلة جديدة',
      body: 'فيه راكب محتاج مشوار',
      payload: tripId,
    );

    break; // أول سواق بس
  }
}
