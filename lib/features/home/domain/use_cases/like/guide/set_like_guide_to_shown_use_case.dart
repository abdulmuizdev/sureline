/// Marks the like guide as shown to the user.
///
/// Updates user preferences to indicate guide completion.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for setting like guide to shown.
class SetLikeGuideToShownUseCase {
  final QuoteRepository quoteRepository;

  /// Creates a new SetLikeGuideToShownUseCase instance.
  const SetLikeGuideToShownUseCase(this.quoteRepository);

  /// Executes the use case to mark like guide as shown.
  ///
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> execute() {
    return quoteRepository.setLikeGuideShown();
  }
}
