import 'package:uberCloneDriver/feature/Auth/domain/entities/auth_user.dart';
import 'package:uberCloneDriver/feature/Auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call({
    required String email,
    required String password,
  }) {
    return _repository.login(email: email, password: password);
  }
}
