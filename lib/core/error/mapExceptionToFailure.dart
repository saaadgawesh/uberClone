

import 'package:uberCloneRider/core/error/exceptions.dart';
import 'package:uberCloneRider/core/error/failures.dart';

Failure mapExceptionToFailure(Exception e) {
  switch (e.runtimeType) {
    case UnauthorizedException _:
      return const UnauthorizedFailure();
    case ForbiddenException _:
      return const ForbiddenFailure();
    case NotFoundException _:
      return const NotFoundFailure();
    case BadRequestException _:
      return const BadRequestFailure();
    case ConflictException _:
      return const ConflictFailure();
    case InternalServerErrorException _:
      return const InternalServerErrorFailure();
    case RequestTimeoutException _:
      return const TimeoutFailure();
    case NoInternetException _:
      return const NoInternetFailure();
    // case FirebaseAuthExceptionCustom:
    //   return const FirebaseAuthFailure();
    // case FirebaseFirestoreException:
    //   return const FirebaseFirestoreFailure();
    // case FirebaseStorageException:
    //   return const FirebaseStorageFailure();
    // case CacheException:
      // return const CacheFailure();
    default:
      return const UnknownFailure();
  }
}
