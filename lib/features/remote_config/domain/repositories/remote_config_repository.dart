import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/remote_config/domain/entities/remote_config_entity.dart';

abstract class RemoteConfigRepository {
  Future<Either<Failure, RemoteConfigEntity>> getRemoteConfig();
}