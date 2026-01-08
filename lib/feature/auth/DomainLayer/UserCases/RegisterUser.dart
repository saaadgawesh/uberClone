
import 'package:uberCloneRider/feature/auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneRider/feature/auth/DomainLayer/Repository/AuthRepository.dart';

class Registeruser {
  final Authrepository _authrepository;

  Registeruser(this._authrepository);
  Future<UserEntity> call(String name, String email, String password) async {
    return await _authrepository.register(email, password, name);
  }
}
