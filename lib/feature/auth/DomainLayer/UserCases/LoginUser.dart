import 'package:uberCloneRider/feature/auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneRider/feature/auth/DomainLayer/Repository/AuthRepository.dart';

class Loginuser {
  final Authrepository _repository;

  Loginuser(this._repository);

  Future<UserEntity> call(String email, String password) async {
    return await _repository.login(email, password);
  }
}
