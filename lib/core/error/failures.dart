import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server error occurred', String? code})
      : super(message: message, code: code);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache error occurred', String? code})
      : super(message: message, code: code);
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure(
      {String message = 'No internet connection', String? code})
      : super(message: message, code: code);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(
      {String message = 'Unauthorized access', String? code})
      : super(message: message, code: code);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'Resource not found', String? code})
      : super(message: message, code: code);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({String message = 'Request timed out', String? code})
      : super(message: message, code: code);
}

class ValidationFailure extends Failure {
  const ValidationFailure({String message = 'Validation failed', String? code})
      : super(message: message, code: code);
}

class UnknownFailure extends Failure {
  const UnknownFailure({String message = 'Unknown error occurred', String? code})
      : super(message: message, code: code);
}