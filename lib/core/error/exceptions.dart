class AppException implements Exception {
  final String message;
  final String? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => message;
}

class ServerException extends AppException {
  const ServerException({String message = 'Server error occurred', String? code})
      : super(message: message, code: code);
}

class CacheException extends AppException {
  const CacheException({String message = 'Cache error occurred', String? code})
      : super(message: message, code: code);
}

class NoInternetConnectionException extends AppException {
  const NoInternetConnectionException(
      {String message = 'No internet connection', String? code})
      : super(message: message, code: code);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(
      {String message = 'Unauthorized access', String? code})
      : super(message: message, code: code);
}

class NotFoundException extends AppException {
  const NotFoundException({String message = 'Resource not found', String? code})
      : super(message: message, code: code);
}

class TimeoutException extends AppException {
  const TimeoutException({String message = 'Request timed out', String? code})
      : super(message: message, code: code);
}

class ValidationException extends AppException {
  const ValidationException({String message = 'Validation failed', String? code})
      : super(message: message, code: code);
}

class UnknownException extends AppException {
  const UnknownException({String message = 'Unknown error occurred', String? code})
      : super(message: message, code: code);
} 