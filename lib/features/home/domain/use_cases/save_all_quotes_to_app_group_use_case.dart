/// Saves all quotes to app group for widget access.
///
/// Persists quotes data for widget functionality.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for saving all quotes to app group.
class SaveAllQuotesToAppGroupUseCase {
  final QuoteRepository quoteRepository;

  /// Creates a new SaveAllQuotesToAppGroupUseCase instance.
  const SaveAllQuotesToAppGroupUseCase(this.quoteRepository);

  /// Executes the use case to save quotes to app group.
  ///
  /// Parameters:
  /// - [isPremium]: Whether the user has premium access
  ///
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> execute({required bool isPremium}) {
    return quoteRepository.saveAllQuotesToAppGroup(isPremium: isPremium);
  }
}
