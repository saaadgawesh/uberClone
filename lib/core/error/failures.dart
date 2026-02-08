import 'package:equatable/equatable.dart';

/// Base Failure
abstract class Failure extends Equatable {
  final String? message;

  const Failure([this.message]);

  @override
  List<Object?> get props => [message];
}

// ===================== API Failures =====================

class ServerFailure extends Failure {
  const ServerFailure([super.message]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message]);
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message]);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message]);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure([super.message]);
}

class ConflictFailure extends Failure {
  const ConflictFailure([super.message]);
}

class InternalServerErrorFailure extends Failure {
  const InternalServerErrorFailure([super.message]);
}

// ===================== Network Failures =====================

class NoInternetFailure extends Failure {
  const NoInternetFailure([super.message]);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message]);
}

// // ===================== Firebase Failures =====================

// class FirebaseAuthFailure extends Failure {
//   const FirebaseAuthFailure([String? message]) : super(message);
// }

// class FirebaseFirestoreFailure extends Failure {
//   const FirebaseFirestoreFailure([String? message]) : super(message);
// }

// class FirebaseStorageFailure extends Failure {
//   const FirebaseStorageFailure([String? message]) : super(message);
// }

// ===================== Cache Failures =====================

class CacheFailure extends Failure {
  const CacheFailure([super.message]);
}

// ===================== Unknown =====================

class UnknownFailure extends Failure {
  const UnknownFailure([super.message]);
}
