import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/remote_config/data/data_source/remote_config_data_source.dart';
import 'package:sureline/features/remote_config/data/model/remote_config_model.dart';
import 'package:sureline/features/remote_config/domain/repositories/remote_config_repository.dart';

class RemoteConfigRepositoryImpl implements RemoteConfigRepository {
  final RemoteConfigDataSource remoteConfigDataSource;

  RemoteConfigRepositoryImpl(this.remoteConfigDataSource);

  @override
  Future<Either<Failure, RemoteConfigModel>> getRemoteConfig() async {
    return remoteConfigDataSource.getRemoteConfig();
  }
}
