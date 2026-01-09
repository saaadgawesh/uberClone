import 'package:uberCloneDriver/feature/Auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneDriver/feature/Auth/dataLayer/repository/AuthRepository.dart';

class Registeruser {
  final Authrepository _authrepository;

  Registeruser(this._authrepository);
  Future<UserEntity> call(String name, String email, String password) async {
    return await _authrepository.register(email, password, name);
  }
}
