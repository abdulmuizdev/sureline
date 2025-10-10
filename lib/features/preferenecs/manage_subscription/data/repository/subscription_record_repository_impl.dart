import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/manage_subscription/data/data_source/manage_subscription_data_source.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/entity/subscription_record_entity.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/repository/subscription_record_repository.dart';

/// Implementation of SubscriptionRecordRepository that handles subscription record operations.
class SubscriptionRecordRepositoryImpl implements SubscriptionRecordRepository {
  final ManageSubscriptionDataSource dataSource;

  /// Creates a new SubscriptionRecordRepositoryImpl instance.
  const SubscriptionRecordRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<SubscriptionRecordEntity>>> getSubscriptionRecords() async {
    return dataSource.getSubscriptionRecords();
  }
}
