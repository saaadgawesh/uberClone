import 'package:injectable/injectable.dart';
import '../../../../core/App_Imports/app_imports.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final Registeruser _registeruser;
  final Loginuser _loginuser;
  final Logoutuser _logoutuser;

  AuthCubit(this._registeruser, this._loginuser, this._logoutuser)
      : super(InitialAuthState());

  Future<void> register(
    String email,
    String password,
    String name,
    int phone,
  ) async {
    emit(LoadingAuthState());
    try {
      await _registeruser(email, password, name, phone);
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(LoadingAuthState());
    try {
      await _loginuser(email, password);
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }

  void customSetState() => emit(CustomSetState());
  Future<void> logout() async {
    emit(LoadingAuthState());

    try {
      await _logoutuser();
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }
}
