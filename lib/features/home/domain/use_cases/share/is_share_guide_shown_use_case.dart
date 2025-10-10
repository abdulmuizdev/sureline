/// Checks if the share guide has been shown to the user.
///
/// Determines whether to display the share guide.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for checking if share guide is shown.
class IsShareGuideShownUseCase {
  final QuoteRepository quoteRepository;

  /// Creates a new IsShareGuideShownUseCase instance.
  const IsShareGuideShownUseCase(this.quoteRepository);

  /// Executes the use case to check if share guide is shown.
  ///
  /// Returns: Either a failure or boolean indicating if guide was shown
  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isShareGuideShown();
  }
}
