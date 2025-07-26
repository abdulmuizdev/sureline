/// Checks if the feed setup guide has been shown to the user.
///
/// Determines whether to display the feed setup guide.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for checking if feed setup is shown.
class IsFeedSetupShownUseCase {
  /// Creates a new IsFeedSetupShownUseCase instance.
  const IsFeedSetupShownUseCase(this.quoteRepository);

  /// Repository for quote operations.
  final QuoteRepository quoteRepository;

  /// Executes the use case to check if feed setup is shown.
  ///
  /// Returns: Either a failure or boolean indicating if guide was shown
  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isFeedSetupShown();
  }
}
