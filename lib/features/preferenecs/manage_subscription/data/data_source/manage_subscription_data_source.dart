import 'package:dartz/dartz.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/manage_subscription/data/model/subscription_record_model.dart';

/// Abstract class defining the contract for manage subscription data operations.
abstract class ManageSubscriptionDataSource {
  /// Retrieves subscription records.
  Future<Either<Failure, List<SubscriptionRecordModel>>> getSubscriptionRecords();
}

/// Implementation of ManageSubscriptionDataSource that handles subscription operations.
class ManageSubscriptionDataSourceImpl implements ManageSubscriptionDataSource {
  /// Creates a new ManageSubscriptionDataSourceImpl instance.
  const ManageSubscriptionDataSourceImpl();

  @override
  Future<Either<Failure, List<SubscriptionRecordModel>>> getSubscriptionRecords() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();

      // Get the latest start date from all purchase dates
      DateTime? latestStartDate;
      if (customerInfo.allPurchaseDates.isNotEmpty) {
        final purchaseDates =
            customerInfo.allPurchaseDates.values
                .where((dateString) => dateString != null)
                .map((dateString) => DateTime.parse(dateString!))
                .toList();

        if (purchaseDates.isNotEmpty) {
          latestStartDate = purchaseDates.reduce((a, b) => a.isAfter(b) ? a : b);
        }
      }

      // Get the latest expiration date from all expiration dates
      DateTime? latestExpirationDate;
      if (customerInfo.allExpirationDates.isNotEmpty) {
        final expirationDates =
            customerInfo.allExpirationDates.values
                .where((dateString) => dateString != null)
                .map((dateString) => DateTime.parse(dateString!))
                .toList();

        if (expirationDates.isNotEmpty) {
          latestExpirationDate = expirationDates.reduce((a, b) => a.isAfter(b) ? a : b);
        }
      }

      final subscriptionRecords = <SubscriptionRecordModel>[];

      // Add start date record if available
      if (latestStartDate != null) {
        subscriptionRecords.add(SubscriptionRecordModel(title: 'Started:', date: latestStartDate));
      }

      // Add renewal date record if available
      if (latestExpirationDate != null) {
        subscriptionRecords.add(
          SubscriptionRecordModel(title: 'Renews:', date: latestExpirationDate),
        );
      }

      return Right(subscriptionRecords);
    } catch (e) {
      return Left(
        ServerFailure(message: 'Failed to retrieve subscription records: ${e.toString()}'),
      );
    }
  }
}
