/// Checks if swipe tutorial has been completed by the user.
///
/// Determines whether to display the swipe tutorial.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for checking if swipe is completed.
class IsSwipeCompletedUseCase {
  final QuoteRepository quoteRepository;

  /// Creates a new IsSwipeCompletedUseCase instance.
  const IsSwipeCompletedUseCase(this.quoteRepository);

  /// Executes the use case to check if swipe tutorial is completed.
  ///
  /// Returns: Either a failure or boolean indicating if tutorial was completed
  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isSwipeComplete();
  }
}
