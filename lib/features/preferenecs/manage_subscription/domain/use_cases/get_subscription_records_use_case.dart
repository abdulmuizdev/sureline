import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/entity/subscription_record_entity.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/repository/subscription_record_repository.dart';

/// Use case for retrieving subscription records.
///
/// This use case encapsulates the business logic for fetching subscription
/// records from the data source. It follows the Clean Architecture pattern
/// by depending on the repository interface rather than concrete implementations.
///
/// The use case returns an Either type for functional error handling,
/// where Left represents a failure and Right represents success with the
/// list of subscription record entities.
class GetSubscriptionRecordsUseCase {
  final SubscriptionRecordRepository repository;

  /// Creates a new GetSubscriptionRecordsUseCase instance.
  ///
  /// [repository] - The repository interface for subscription record operations
  const GetSubscriptionRecordsUseCase({required this.repository});

  /// Executes the use case to retrieve subscription records.
  ///
  /// This method calls the repository to fetch all subscription-related
  /// records and returns the result wrapped in an Either type for
  /// proper error handling.
  ///
  /// Returns:
  /// - Left<Failure> - If the operation fails (network error, etc.)
  /// - Right<List<SubscriptionRecordEntity>> - If the operation succeeds with the records list
  Future<Either<Failure, List<SubscriptionRecordEntity>>> execute() async {
    return repository.getSubscriptionRecords();
  }
}
