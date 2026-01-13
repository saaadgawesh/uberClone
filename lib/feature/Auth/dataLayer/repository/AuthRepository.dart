import '../../../../core/App_Imports/app_imports.dart';
abstract class Authrepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(
    String email,
    String password,
    String name,
    int phone,
    int carModel,
    String carNumber,
    GeoPoint location,
  );
  Future<void> logout();
}
