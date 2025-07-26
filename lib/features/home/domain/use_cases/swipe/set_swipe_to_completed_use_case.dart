/// Marks swipe tutorial as completed for the user.
///
/// Updates user preferences to indicate swipe tutorial completion.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for setting swipe to completed.
class SetSwipeToCompletedUseCase {
  final QuoteRepository quoteRepository;

  /// Creates a new SetSwipeToCompletedUseCase instance.
  const SetSwipeToCompletedUseCase(this.quoteRepository);

  /// Executes the use case to mark swipe tutorial as completed.
  ///
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> execute() {
    return quoteRepository.setSwipeToCompleted();
  }
}
