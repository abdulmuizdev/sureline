/// Checks if the like guide has been shown to the user.
///
/// Determines whether to display the like guide.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for checking if like guide is shown.
class IsLikeGuideShownUseCase {
  final QuoteRepository quoteRepository;

  /// Creates a new IsLikeGuideShownUseCase instance.
  const IsLikeGuideShownUseCase(this.quoteRepository);

  /// Executes the use case to check if like guide is shown.
  ///
  /// Returns: Either a failure or boolean indicating if guide was shown
  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isLikeGuideShown();
  }
}
