import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String? id;
  final String? name;
  final String? email;
  final int? phone;
  final int? carModel;
  final String? carNumber;
  final GeoPoint? location;

  const UserEntity({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.carModel,
    this.carNumber,
    this.location,
  });
}
