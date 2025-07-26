/// Exception classes for the Sureline app.

/// Base exception class for all exceptions in the Sureline app.
class AppException implements Exception {
  /// Human-readable error message.
  final String message;

  /// Optional error code for programmatic handling.
  final String? code;

  /// Creates a new [AppException] instance.
  /// [message] - Human-readable error description
  /// [code] - Optional error code for programmatic handling
  const AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Exception representing server-side errors.
/// Default message: 'Server error occurred'
class ServerException extends AppException {
  /// Creates a new [ServerException] instance.
  /// [message] - Description of the server error
  /// [code] - Optional server error code
  const ServerException({String message = 'Server error occurred', String? code})
    : super(message: message, code: code);
}

/// Exception representing cache or local storage errors.
/// Default message: 'Cache error occurred'
class CacheException extends AppException {
  /// Creates a new [CacheException] instance.
  /// [message] - Description of the cache error
  /// [code] - Optional cache error code
  const CacheException({String message = 'Cache error occurred', String? code})
    : super(message: message, code: code);
}

/// Exception representing network connectivity issues.
/// Default message: 'Network error occurred'
class NetworkException extends AppException {
  /// Creates a new [NetworkException] instance.
  /// [message] - Description of the network error
  /// [code] - Optional network error code
  const NetworkException({String message = 'Network error occurred', String? code})
    : super(message: message, code: code);
}

/// Exception representing authentication or authorization errors.
/// Default message: 'Authentication error occurred'
class AuthException extends AppException {
  /// Creates a new [AuthException] instance.
  /// [message] - Description of the authentication error
  /// [code] - Optional authentication error code
  const AuthException({String message = 'Authentication error occurred', String? code})
    : super(message: message, code: code);
}

/// Exception representing resource not found errors.
/// Default message: 'Resource not found'
class NotFoundException extends AppException {
  /// Creates a new [NotFoundException] instance.
  /// [message] - Description of the not found error
  /// [code] - Optional not found error code
  const NotFoundException({String message = 'Resource not found', String? code})
    : super(message: message, code: code);
}

/// Exception representing request timeout errors.
/// Default message: 'Request timeout'
class TimeoutException extends AppException {
  /// Creates a new [TimeoutException] instance.
  /// [message] - Description of the timeout error
  /// [code] - Optional timeout error code
  const TimeoutException({String message = 'Request timeout', String? code})
    : super(message: message, code: code);
}

/// Exception representing data validation errors.
/// Default message: 'Validation error occurred'
class ValidationException extends AppException {
  /// Creates a new [ValidationException] instance.
  /// [message] - Description of the validation error
  /// [code] - Optional validation error code
  const ValidationException({String message = 'Validation error occurred', String? code})
    : super(message: message, code: code);
}

/// Exception representing unknown or unexpected errors.
/// Default message: 'Unknown error occurred'
class UnknownException extends AppException {
  /// Creates a new [UnknownException] instance.
  /// [message] - Description of the unknown error
  /// [code] - Optional unknown error code
  const UnknownException({String message = 'Unknown error occurred', String? code})
    : super(message: message, code: code);
}
