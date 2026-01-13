import 'package:uberCloneRider/feature/Auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneRider/feature/Auth/dataLayer/repository/AuthRepository.dart';

class Registeruser {
  final Authrepository _authrepository;

  Registeruser(this._authrepository);
  Future<UserEntity> call(
    String email,
    String password,
    String name,
    int phone,
  ) async {
    return await _authrepository.register(email, password, name, phone);
  }
}
