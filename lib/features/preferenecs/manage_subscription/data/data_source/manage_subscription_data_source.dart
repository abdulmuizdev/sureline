import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/manage_subscription/data/model/subscription_record_model.dart';

abstract class ManageSubscriptionDataSource {
  Future<Either<Failure, List<SubscriptionRecordModel>>>
  getSubscriptionRecords();
}

class ManageSubscriptionDataSourceImpl implements ManageSubscriptionDataSource {
  @override
  Future<Either<Failure, List<SubscriptionRecordModel>>>
  getSubscriptionRecords() async {
    final subscriptionRecords = [
      SubscriptionRecordModel(
        title: 'Started:',
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      SubscriptionRecordModel(title: 'Ended:', date: DateTime.now()),
    ];
    return Right(subscriptionRecords);
  }
}
