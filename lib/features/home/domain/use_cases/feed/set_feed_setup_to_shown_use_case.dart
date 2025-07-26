/// Marks the feed setup guide as shown to the user.
///
/// Updates user preferences to indicate feed setup completion.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for setting feed setup to shown.
class SetFeedSetupToShownUseCase {
  /// Creates a new SetFeedSetupToShownUseCase instance.
  const SetFeedSetupToShownUseCase(this.quoteRepository);

  /// Repository for quote operations.
  final QuoteRepository quoteRepository;

  /// Executes the use case to mark feed setup as shown.
  ///
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> execute() {
    return quoteRepository.setFeedSetupShown();
  }
}
