import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uberCloneDriver/feature/Auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneDriver/feature/Auth/dataLayer/repository/AuthRepository.dart';

class Registeruser {
  final Authrepository _authrepository;

  Registeruser(this._authrepository);
  Future<UserEntity> call(
    String email,
    String password,
    String name,
    int phone,
    int carModel,
    String carNumber,
    GeoPoint location,
  ) async {
    return await _authrepository.register(
      email,
      password,
      name,
      phone,
      carModel,
      carNumber,
      location,
    );
  }
}
