import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/entity/subscription_record_entity.dart';

/// Abstract repository interface for subscription record operations.
///
/// This repository defines the contract for all subscription-related data
/// operations, including retrieving subscription records and managing
/// subscription status. It follows the Clean Architecture pattern by
/// providing a clean interface that the domain layer depends on.
///
/// The repository handles subscription data that may come from various
/// sources like in-app purchases, subscription services, or local storage.
abstract class SubscriptionRecordRepository {
  /// Retrieves subscription records for the current user.
  ///
  /// This method fetches all subscription-related records including
  /// current subscription status, historical subscription data, and
  /// subscription management information.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (network error, etc.)
  /// - Right<List<SubscriptionRecordEntity>> - If the operation succeeds with the records list
  Future<Either<Failure, List<SubscriptionRecordEntity>>> getSubscriptionRecords();
}
