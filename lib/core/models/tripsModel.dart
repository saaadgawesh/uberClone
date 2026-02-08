import 'package:hive/hive.dart';

 part 'tripsModel.g.dart';

@HiveType(typeId: 1)
class TripsModel extends HiveObject {
  @HiveField(0)
  final String tripId;

  @HiveField(1)
  final String status; // deleted | completed

  @HiveField(2)
  final DateTime actionDate;

  TripsModel({
    required this.tripId,
    required this.status,
    required this.actionDate,
  });
}
