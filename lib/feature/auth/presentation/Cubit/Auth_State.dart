// import 'package:equatable/equatable.dart';

// abstract class AuthState extends Equatable {}

// class InitialAuthState extends AuthState {
//   @override
//   List<Object?> get props => [];
// }

// class customSetstate extends AuthState {
//   @override
//   List<Object?> get props => throw customSetstate();
// }

// class LoadingAuthState extends AuthState {
//   @override
//   List<Object?> get props => [];
// }

// class SuccessAuthState extends AuthState {
//   @override
//   List<Object?> get props => [];
// }

// class ErrorAuthState extends AuthState {
//   final String e;

//   ErrorAuthState(this.e);

//   @override
//   List<Object?> get props => [e];
// }import 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class InitialAuthState extends AuthState {
  const InitialAuthState();
}

class CustomSetState extends AuthState {
  const CustomSetState();
}

class LoadingAuthState extends AuthState {
  const LoadingAuthState();
}

class SuccessAuthState extends AuthState {
  const SuccessAuthState();
}

class ErrorAuthState extends AuthState {
  final String e;

  const ErrorAuthState(this.e);

  @override
  List<Object?> get props => [e];
}
