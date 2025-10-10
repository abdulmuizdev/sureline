/// Marks the share guide as shown to the user.
///
/// Updates user preferences to indicate share guide completion.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for setting share guide to shown.
class SetShareGuideToShownUseCase {
  final QuoteRepository quoteRepository;

  /// Creates a new SetShareGuideToShownUseCase instance.
  const SetShareGuideToShownUseCase(this.quoteRepository);

  /// Executes the use case to mark share guide as shown.
  ///
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> execute() {
    return quoteRepository.setShareGuideShown();
  }
}
