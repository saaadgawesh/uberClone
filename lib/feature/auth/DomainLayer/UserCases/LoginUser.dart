import 'package:injectable/injectable.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/userEntity/AuthEntity.dart';
import 'package:uberCloneRider/feature/Auth/dataLayer/repository/AuthRepository.dart';

@injectable
class Loginuser {
  final Authrepository _repository;

  Loginuser(this._repository);

  Future<UserEntity> call(String email, String password) async {
    return await _repository.login(email, password);
  }
}
