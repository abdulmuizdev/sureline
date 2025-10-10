import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/core/network/network_info.dart';
import 'package:sureline/features/remote_config/data/model/remote_config_model.dart';

abstract class RemoteConfigDataSource {
  Future<Either<Failure, RemoteConfigModel>> getRemoteConfig();
}

class RemoteConfigDataSourceImpl implements RemoteConfigDataSource {
  final Dio dio;
  final NetworkInfo networkInfo;

  RemoteConfigDataSourceImpl(this.dio, this.networkInfo);

  @override
  Future<Either<Failure, RemoteConfigModel>> getRemoteConfig() async {
    RemoteConfigModel model = Constants.remoteConfigModel;
    try {
      // final response = await dio.get(Endpoints.getRemoteConfigEndpoint());

      // if (response.statusCode == 200) {
      //   model = RemoteConfigModel.fromJson(response.data);
      // } else {
      //   model = Constants.remoteConfigModel;
      // }
    } catch (e) {
      debugPrint('${e}');
      // model = Constants.remoteConfigModel;
    }
    return Right(model);
  }

  // @override
  // Future<Either<Failure, RemoteConfigModel>> getRemoteConfig() async {
  //   if (!await networkInfo.isConnected) {
  //     return const Left(NoInternetConnectionFailure());
  //   }
  //
  //   try {
  //     final response = await dio.get('/api/v1/remote-config');
  //
  //     if (response.statusCode == 200) {
  //       return Right(RemoteConfigModel.fromJson(response.data));
  //     } else {
  //       return const Left(ServerFailure());
  //     }
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionTimeout ||
  //         e.type == DioExceptionType.receiveTimeout ||
  //         e.type == DioExceptionType.sendTimeout) {
  //       return const Left(TimeoutFailure());
  //     } else if (e.response?.statusCode == 401) {
  //       return const Left(UnauthorizedFailure());
  //     } else if (e.response?.statusCode == 404) {
  //       return const Left(NotFoundFailure());
  //     } else {
  //       return const Left(ServerFailure());
  //     }
  //   } catch (e) {
  //     return const Left(ServerFailure());
  //   }
  // }
}
