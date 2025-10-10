/// Error handling failures for the Sureline app.

import 'package:equatable/equatable.dart';

/// Abstract base class for all failure types in the Sureline app.
abstract class Failure extends Equatable {
  /// Human-readable error message.
  final String message;

  /// Optional error code for programmatic handling.
  final String? code;

  /// Creates a new [Failure] instance.
  /// [message] - Human-readable error description
  /// [code] - Optional error code for programmatic handling
  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Failure representing server-side errors.
/// Default message: 'Server error occurred'
class ServerFailure extends Failure {
  /// Creates a new [ServerFailure] instance.
  /// [message] - Description of the server error
  /// [code] - Optional server error code
  const ServerFailure({String message = 'Server error occurred', String? code})
    : super(message: message, code: code);
}

/// Failure representing cache or local storage errors.
/// Default message: 'Cache error occurred'
class CacheFailure extends Failure {
  /// Creates a new [CacheFailure] instance.
  /// [message] - Description of the cache error
  /// [code] - Optional cache error code
  const CacheFailure({String message = 'Cache error occurred', String? code})
    : super(message: message, code: code);
}

/// Failure representing network connectivity issues.
/// Default message: 'Network error occurred'
class NetworkFailure extends Failure {
  /// Creates a new [NetworkFailure] instance.
  /// [message] - Description of the network error
  /// [code] - Optional network error code
  const NetworkFailure({String message = 'Network error occurred', String? code})
    : super(message: message, code: code);
}

/// Failure representing authentication or authorization errors.
/// Default message: 'Authentication error occurred'
class AuthFailure extends Failure {
  /// Creates a new [AuthFailure] instance.
  /// [message] - Description of the authentication error
  /// [code] - Optional authentication error code
  const AuthFailure({String message = 'Authentication error occurred', String? code})
    : super(message: message, code: code);
}

/// Failure representing resource not found errors.
/// Default message: 'Resource not found'
class NotFoundFailure extends Failure {
  /// Creates a new [NotFoundFailure] instance.
  /// [message] - Description of the not found error
  /// [code] - Optional not found error code
  const NotFoundFailure({String message = 'Resource not found', String? code})
    : super(message: message, code: code);
}

/// Failure representing request timeout errors.
/// Default message: 'Request timeout'
class TimeoutFailure extends Failure {
  /// Creates a new [TimeoutFailure] instance.
  /// [message] - Description of the timeout error
  /// [code] - Optional timeout error code
  const TimeoutFailure({String message = 'Request timeout', String? code})
    : super(message: message, code: code);
}

/// Failure representing data validation errors.
/// Default message: 'Validation error occurred'
class ValidationFailure extends Failure {
  /// Creates a new [ValidationFailure] instance.
  /// [message] - Description of the validation error
  /// [code] - Optional validation error code
  const ValidationFailure({String message = 'Validation error occurred', String? code})
    : super(message: message, code: code);
}

/// Failure representing unknown or unexpected errors.
/// Default message: 'Unknown error occurred'
class UnknownFailure extends Failure {
  /// Creates a new [UnknownFailure] instance.
  /// [message] - Description of the unknown error
  /// [code] - Optional unknown error code
  const UnknownFailure({String message = 'Unknown error occurred', String? code})
    : super(message: message, code: code);
}
