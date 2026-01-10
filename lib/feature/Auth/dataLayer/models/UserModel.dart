import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  final String? id;
  final String? name;
  final String? email;
  final int? phone;
  final int? carModel;
  final String? carNumber;
  final GeoPoint? location;

  Usermodel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.carModel,
    this.carNumber,
    this.location,
  });

  Map<String, dynamic> tojson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "carModel": carModel,
    "carNumber": carNumber,
    "location": location,
  };

  factory Usermodel.fromjson(Map<String, dynamic> json) {
    return Usermodel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      carModel: json['carModel'],
      carNumber: json['carNumber'],
      location: json['location'],
    );
  }
}
