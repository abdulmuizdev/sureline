import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/manage_subscription/data/model/subscription_record_model.dart';
import 'package:sureline/features/manage_subscription/domain/entity/subscription_record_entity.dart';

abstract class SubscriptionRecordRepository {
  Future<Either<Failure, List<SubscriptionRecordEntity>>>
  getSubscriptionRecords();
}
