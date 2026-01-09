import 'package:uberCloneDriver/feature/Auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneDriver/feature/Auth/dataLayer/repository/AuthRepository.dart';

class Loginuser {
  final Authrepository _repository;

  Loginuser(this._repository);

  Future<UserEntity> call(String email, String password) async {
    return await _repository.login(email, password);
  }
}
