
import 'package:uberCloneRider/feature/Auth/dataLayer/repository/AuthRepository.dart';

class Logoutuser {
  final Authrepository _authrepository;

  Logoutuser(this._authrepository);
  Future<void> call() async {
    await _authrepository.logout();
  }
}
