import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uberCloneDriver/feature/Auth/DomainLayer/UserCases/LoginUser.dart';
import 'package:uberCloneDriver/feature/Auth/DomainLayer/UserCases/RegisterUser.dart';
import 'package:uberCloneDriver/feature/Auth/presentation/Cubit/Auth_State.dart';

class AuthCubit extends Cubit<AuthState> {
  final Registeruser _registeruser;
  final Loginuser _loginuser;

  AuthCubit(this._registeruser, this._loginuser) : super(InitialAuthState());

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

  Future<void> logout() async {
    emit(LoadingAuthState());

    try {
      emit(SuccessAuthState());
    } catch (e) {
      emit(ErrorAuthState(e.toString()));
    }
  }
}
