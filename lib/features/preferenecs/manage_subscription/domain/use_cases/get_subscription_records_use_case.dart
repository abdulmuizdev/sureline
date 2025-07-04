import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/entity/subscription_record_entity.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/repository/subscription_record_repository.dart';

class GetSubscriptionRecordsUseCase {
  final SubscriptionRecordRepository repository;

  GetSubscriptionRecordsUseCase({required this.repository});

  Future<Either<Failure, List<SubscriptionRecordEntity>>> execute() async {
    return repository.getSubscriptionRecords();
  }
}
