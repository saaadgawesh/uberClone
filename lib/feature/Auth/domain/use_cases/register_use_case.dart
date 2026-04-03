import 'package:uberCloneDriver/feature/Auth/domain/entities/auth_user.dart';
import 'package:uberCloneDriver/feature/Auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  Future<AuthUser> call({
    required String email,
    required String password,
    required String name,
    required int phone,
  }) {
    return _repository.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }
}
