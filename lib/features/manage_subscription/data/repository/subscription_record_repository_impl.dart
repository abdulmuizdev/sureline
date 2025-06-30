import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/manage_subscription/data/data_source/manage_subscription_data_source.dart';
import 'package:sureline/features/manage_subscription/domain/entity/subscription_record_entity.dart';
import 'package:sureline/features/manage_subscription/domain/repository/subscription_record_repository.dart';

class SubscriptionRecordRepositoryImpl implements SubscriptionRecordRepository {
  final ManageSubscriptionDataSource dataSource;

  SubscriptionRecordRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<SubscriptionRecordEntity>>>
  getSubscriptionRecords() async {
    return dataSource.getSubscriptionRecords();
  }
}
