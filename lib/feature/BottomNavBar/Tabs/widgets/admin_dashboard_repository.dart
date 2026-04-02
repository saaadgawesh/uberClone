import 'package:cloud_firestore/cloud_firestore.dart';

class AdminOverviewStats {
  const AdminOverviewStats({
    required this.totalTrips,
    required this.requestedTrips,
    required this.activeTrips,
    required this.completedTrips,
    required this.unassignedTrips,
  });

  final int totalTrips;
  final int requestedTrips;
  final int activeTrips;
  final int completedTrips;
  final int unassignedTrips;
}

class AdminTripRecord {
  const AdminTripRecord({
    required this.id,
    required this.riderName,
    required this.driverName,
    required this.pickup,
    required this.destination,
    required this.status,
    required this.fare,
    required this.createdAt,
  });

  final String id;
  final String riderName;
  final String driverName;
  final String pickup;
  final String destination;
  final String status;
  final double fare;
  final DateTime? createdAt;
}

class AdminDriverRecord {
  const AdminDriverRecord({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.carModel,
    required this.carNumber,
    required this.status,
    required this.isOnline,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String carModel;
  final String carNumber;
  final String status;
  final bool isOnline;
}

class AdminRiderRecord {
  const AdminRiderRecord({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
}

class AdminPaymentRecord {
  const AdminPaymentRecord({
    required this.id,
    required this.tripId,
    required this.riderId,
    required this.driverId,
    required this.amount,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String tripId;
  final String riderId;
  final String driverId;
  final double amount;
  final String status;
  final DateTime? createdAt;
}

class AdminSupportRequestRecord {
  const AdminSupportRequestRecord({
    required this.id,
    required this.riderId,
    required this.riderName,
    required this.type,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String riderId;
  final String riderName;
  final String type;
  final String message;
  final String status;
  final DateTime? createdAt;
}

class AdminDriverTripSummary {
  const AdminDriverTripSummary({
    required this.driverId,
    required this.driverName,
    required this.totalTrips,
    required this.completedTrips,
    required this.activeTrips,
  });

  final String driverId;
  final String driverName;
  final int totalTrips;
  final int completedTrips;
  final int activeTrips;
}

class AdminDashboardRepository {
  AdminDashboardRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<int> watchCollectionCount(List<String> collectionNames) {
    return _resolveCollection(collectionNames).snapshots().map(
      (snapshot) => snapshot.size,
    );
  }

  Stream<List<AdminTripRecord>> watchTrips() {
    return _firestore.collection('trips').snapshots().map((snapshot) {
      final trips = snapshot.docs
          .map((doc) => _mapTrip(doc))
          .toList()
        ..sort((a, b) {
          final aValue = a.createdAt?.millisecondsSinceEpoch ?? 0;
          final bValue = b.createdAt?.millisecondsSinceEpoch ?? 0;
          return bValue.compareTo(aValue);
        });
      return trips;
    });
  }

  Stream<List<AdminDriverRecord>> watchDrivers() {
    return _firestore.collection('Driver').snapshots().map((snapshot) {
      final drivers = snapshot.docs
          .map((doc) => _mapDriver(doc))
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      return drivers;
    });
  }

  Stream<List<AdminDriverRecord>> watchAvailableDrivers() {
    return watchDrivers().map(
      (drivers) => drivers
          .where((driver) => driver.isOnline && driver.status == 'available')
          .toList(),
    );
  }

  Stream<List<AdminRiderRecord>> watchRiders() {
    return _firestore.collection('Rider').snapshots().map((snapshot) {
      final riders = snapshot.docs
          .map((doc) => _mapRider(doc))
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      return riders;
    });
  }

  Stream<List<AdminPaymentRecord>> watchPayments() {
    return _firestore.collection('payments').snapshots().map((snapshot) {
      final payments = snapshot.docs
          .map((doc) => _mapPayment(doc))
          .toList()
        ..sort((a, b) {
          final aValue = a.createdAt?.millisecondsSinceEpoch ?? 0;
          final bValue = b.createdAt?.millisecondsSinceEpoch ?? 0;
          return bValue.compareTo(aValue);
        });
      return payments;
    });
  }

  Stream<List<AdminSupportRequestRecord>> watchSupportRequests() {
    return _firestore.collection('support_requests').snapshots().map((snapshot) {
      final requests = snapshot.docs
          .map((doc) => _mapSupportRequest(doc))
          .toList()
        ..sort((a, b) {
          final aValue = a.createdAt?.millisecondsSinceEpoch ?? 0;
          final bValue = b.createdAt?.millisecondsSinceEpoch ?? 0;
          return bValue.compareTo(aValue);
        });
      return requests;
    });
  }

  Stream<List<AdminDriverTripSummary>> watchDriverTripSummaries() {
    return watchDrivers().asyncMap((drivers) async {
      final tripsSnapshot = await _firestore.collection('trips').get();
      final trips = tripsSnapshot.docs.map((doc) => doc.data()).toList();

      return drivers.map((driver) {
        final driverTrips = trips.where((trip) => trip['driverId'] == driver.id);
        final completedTrips = driverTrips
            .where((trip) => trip['status'] == 'completed')
            .length;
        final activeTrips = driverTrips
            .where(
              (trip) => trip['status'] == 'accepted' || trip['status'] == 'ongoing',
            )
            .length;

        return AdminDriverTripSummary(
          driverId: driver.id,
          driverName: driver.name,
          totalTrips: driverTrips.length,
          completedTrips: completedTrips,
          activeTrips: activeTrips,
        );
      }).toList()
        ..sort((a, b) => b.totalTrips.compareTo(a.totalTrips));
    });
  }

  Stream<AdminOverviewStats> watchOverviewStats() {
    return watchTrips().map((trips) {
      final requested = trips
          .where((trip) => trip.status == 'requested' || trip.status == 'pending')
          .length;
      final active = trips
          .where((trip) => trip.status == 'accepted' || trip.status == 'ongoing')
          .length;
      final completed = trips.where((trip) => trip.status == 'completed').length;
      final unassigned = trips
          .where((trip) => trip.status == 'no_driver' || trip.driverName == 'لم يتم التعيين')
          .length;

      return AdminOverviewStats(
        totalTrips: trips.length,
        requestedTrips: requested,
        activeTrips: active,
        completedTrips: completed,
        unassignedTrips: unassigned,
      );
    });
  }

  CollectionReference<Map<String, dynamic>> _resolveCollection(
    List<String> collectionNames,
  ) {
    return _firestore.collection(collectionNames.first);
  }

  AdminTripRecord _mapTrip(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};

    return AdminTripRecord(
      id: doc.id,
      riderName: _readString(
        data,
        ['riderName', 'userName', 'customerName', 'passengerName'],
        fallback: 'راكب غير محدد',
      ),
      driverName: _readString(
        data,
        ['driverName', 'captainName', 'driver'],
        fallback: 'لم يتم التعيين',
      ),
      pickup: _readString(
        data,
        ['pickupAddress', 'pickup', 'from', 'origin'],
        fallback: 'نقطة الانطلاق غير متاحة',
      ),
      destination: _readString(
        data,
        ['destinationAddress', 'destination', 'to'],
        fallback: 'الوجهة غير متاحة',
      ),
      status: _readString(data, ['status'], fallback: 'pending'),
      fare: _readDouble(data, ['fare', 'price', 'total']),
      createdAt: _readDateTime(data, ['createdAt', 'updatedAt', 'timestamp']),
    );
  }

  AdminDriverRecord _mapDriver(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};

    return AdminDriverRecord(
      id: doc.id,
      name: _readString(data, ['name'], fallback: 'سائق غير معروف'),
      email: _readString(data, ['email'], fallback: 'غير متاح'),
      phone: _readString(data, ['phone'], fallback: 'غير متاح'),
      carModel: _readString(data, ['carModel'], fallback: 'غير محدد'),
      carNumber: _readString(data, ['carNumber'], fallback: 'غير محدد'),
      status: _readString(data, ['status'], fallback: 'available'),
      isOnline: data['isOnline'] == true,
    );
  }

  AdminRiderRecord _mapRider(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};

    return AdminRiderRecord(
      id: doc.id,
      name: _readString(data, ['name'], fallback: 'راكب غير معروف'),
      email: _readString(data, ['email'], fallback: 'غير متاح'),
      phone: _readString(data, ['phone'], fallback: 'غير متاح'),
    );
  }

  AdminPaymentRecord _mapPayment(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};

    return AdminPaymentRecord(
      id: doc.id,
      tripId: _readString(data, ['tripId'], fallback: 'غير متاح'),
      riderId: _readString(data, ['riderId'], fallback: 'غير متاح'),
      driverId: _readString(data, ['driverId'], fallback: 'غير متاح'),
      amount: _readDouble(data, ['amount']),
      status: _readString(data, ['status'], fallback: 'pending'),
      createdAt: _readDateTime(data, ['createdAt', 'updatedAt']),
    );
  }

  AdminSupportRequestRecord _mapSupportRequest(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};

    return AdminSupportRequestRecord(
      id: doc.id,
      riderId: _readString(data, ['riderId'], fallback: 'غير متاح'),
      riderName: _readString(data, ['riderName'], fallback: 'راكب'),
      type: _readString(data, ['type'], fallback: 'inquiry'),
      message: _readString(data, ['message'], fallback: 'لا يوجد نص'),
      status: _readString(data, ['status'], fallback: 'open'),
      createdAt: _readDateTime(data, ['createdAt', 'updatedAt']),
    );
  }

  Future<void> assignTripToDriver({
    required String tripId,
    required String driverId,
  }) async {
    final tripRef = _firestore.collection('trips').doc(tripId);
    final driverRef = _firestore.collection('Driver').doc(driverId);

    await _firestore.runTransaction((transaction) async {
      final tripSnapshot = await transaction.get(tripRef);
      final driverSnapshot = await transaction.get(driverRef);

      if (!tripSnapshot.exists || !driverSnapshot.exists) {
        throw Exception('Trip or driver not found');
      }

      transaction.update(tripRef, {
        'driverId': driverId,
        'status': 'requested',
        'updatedAt': FieldValue.serverTimestamp(),
      });

      transaction.update(driverRef, {
        'status': 'available',
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });
  }

  String _readString(
    Map<String, dynamic> data,
    List<String> keys, {
    required String fallback,
  }) {
    for (final key in keys) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }
    return fallback;
  }

  double _readDouble(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is num) {
        return value.toDouble();
      }
      if (value is String) {
        final parsed = double.tryParse(value);
        if (parsed != null) {
          return parsed;
        }
      }
    }
    return 0;
  }

  DateTime? _readDateTime(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      if (value is String) {
        final parsed = DateTime.tryParse(value);
        if (parsed != null) {
          return parsed;
        }
      }
    }
    return null;
  }
}
