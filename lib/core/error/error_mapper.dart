import 'package:dio/dio.dart';
import 'package:sureline/core/error/exceptions.dart';
import 'package:sureline/core/error/failures.dart';

class ErrorMapper {
  static Failure mapExceptionToFailure(Exception exception) {
    if (exception is AppException) {
      return _mapAppExceptionToFailure(exception);
    } else if (exception is DioException) {
      return _mapDioExceptionToFailure(exception);
    } else {
      return const UnknownFailure();
    }
  }

  static Failure _mapAppExceptionToFailure(AppException exception) {
    switch (exception.runtimeType) {
      case ServerException:
        return ServerFailure(message: exception.message, code: exception.code);
      case CacheException:
        return CacheFailure(message: exception.message, code: exception.code);
      case NoInternetConnectionException:
        return const NoInternetConnectionFailure();
      case UnauthorizedException:
        return const UnauthorizedFailure();
      case NotFoundException:
        return const NotFoundFailure();
      case TimeoutException:
        return const TimeoutFailure();
      case ValidationException:
        return ValidationFailure(
          message: exception.message,
          code: exception.code,
        );
      default:
        return UnknownFailure(message: exception.message, code: exception.code);
    }
  }

  static Failure _mapDioExceptionToFailure(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const TimeoutFailure();
      case DioExceptionType.badResponse:
        return _mapDioResponseToFailure(exception.response);
      case DioExceptionType.connectionError:
        return const NoInternetConnectionFailure();
      default:
        return const ServerFailure();
    }
  }

  static Failure _mapDioResponseToFailure(Response? response) {
    if (response == null) return const ServerFailure();

    switch (response.statusCode) {
      case 401:
        return const UnauthorizedFailure();
      case 404:
        return const NotFoundFailure();
      case 422:
        return ValidationFailure(
          message: response.data['message'] ?? 'Validation failed',
          code: response.data['code'],
        );
      default:
        return ServerFailure(
          message: response.data['message'] ?? 'Server error occurred',
          code: response.data['code'],
        );
    }
  }
}
