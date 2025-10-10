/// Error mapping utilities for the Sureline app.

import 'package:dio/dio.dart';
import 'package:sureline/core/error/exceptions.dart';
import 'package:sureline/core/error/failures.dart';

/// Maps exceptions to failures for consistent error handling.
class ErrorMapper {
  /// Maps any exception to a failure.
  /// [exception] - The exception to map
  /// Returns: A failure object
  static Failure mapExceptionToFailure(dynamic exception) {
    if (exception is AppException) {
      return _mapAppExceptionToFailure(exception);
    } else if (exception is DioException) {
      return _mapDioExceptionToFailure(exception);
    } else {
      return const UnknownFailure();
    }
  }

  /// Maps app exceptions to failures.
  /// [exception] - The app exception to map
  /// Returns: A failure object
  static Failure _mapAppExceptionToFailure(AppException exception) {
    switch (exception.runtimeType) {
      case ServerException:
        return ServerFailure(message: exception.message, code: exception.code);
      case CacheException:
        return CacheFailure(message: exception.message, code: exception.code);
      case NetworkException:
        return NetworkFailure(message: exception.message, code: exception.code);
      case AuthException:
        return AuthFailure(message: exception.message, code: exception.code);
      case NotFoundException:
        return NotFoundFailure(message: exception.message, code: exception.code);
      case TimeoutException:
        return TimeoutFailure(message: exception.message, code: exception.code);
      case ValidationException:
        return ValidationFailure(message: exception.message, code: exception.code);
      default:
        return UnknownFailure(message: exception.message, code: exception.code);
    }
  }

  /// Maps Dio exceptions to failures.
  /// [exception] - The Dio exception to map
  /// Returns: A failure object
  static Failure _mapDioExceptionToFailure(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(message: 'Request timeout');
      case DioExceptionType.badResponse:
        return _mapHttpStatusToFailure(exception.response?.statusCode);
      case DioExceptionType.cancel:
        return UnknownFailure(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return NetworkFailure(message: 'Network connection error');
      default:
        return UnknownFailure(message: 'Network error occurred');
    }
  }

  /// Maps HTTP status codes to failures.
  /// [statusCode] - The HTTP status code
  /// Returns: A failure object
  static Failure _mapHttpStatusToFailure(int? statusCode) {
    switch (statusCode) {
      case 401:
        return AuthFailure(message: 'Unauthorized');
      case 403:
        return AuthFailure(message: 'Forbidden');
      case 404:
        return NotFoundFailure(message: 'Resource not found');
      case 408:
        return TimeoutFailure(message: 'Request timeout');
      case 500:
        return ServerFailure(message: 'Internal server error');
      case 502:
      case 503:
      case 504:
        return ServerFailure(message: 'Server unavailable');
      default:
        return ServerFailure(message: 'Server error occurred');
    }
  }
}
