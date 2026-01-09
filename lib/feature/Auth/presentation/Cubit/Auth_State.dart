import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class InitialAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoadingAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SuccessAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ErrorAuthState extends AuthState {
  final String e;

  ErrorAuthState(this.e);

  @override
  List<Object?> get props => [e];
}
