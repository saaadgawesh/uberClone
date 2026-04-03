import 'package:firebase_auth/firebase_auth.dart';
import 'package:uberCloneDriver/feature/Auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:uberCloneDriver/feature/Auth/domain/entities/auth_user.dart';
import 'package:uberCloneDriver/feature/Auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final FirebaseAuthDataSource _remoteDataSource;

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _remoteDataSource.login(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e, fallback: 'login-failed'));
    }
  }

  @override
  Future<AuthUser> register({
    required String email,
    required String password,
    required String name,
    required int phone,
  }) async {
    try {
      return await _remoteDataSource.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapAuthError(e, fallback: 'register-failed'));
    }
  }

  @override
  Future<void> logout() {
    return _remoteDataSource.logout();
  }

  String _mapAuthError(FirebaseAuthException error, {required String fallback}) {
    switch (error.code) {
      case 'email-already-in-use':
        return 'email-already-in-use';
      case 'invalid-email':
        return 'invalid-email';
      case 'weak-password':
        return 'weak-password';
      case 'user-disabled':
        return 'user-disabled';
      case 'user-not-found':
        return 'user-not-found';
      case 'wrong-password':
        return 'wrong-password';
      default:
        return error.message ?? fallback;
    }
  }
}
