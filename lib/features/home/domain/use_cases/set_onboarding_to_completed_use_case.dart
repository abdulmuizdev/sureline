/// Marks onboarding as completed for the user.
///
/// Updates user preferences to indicate onboarding completion.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for setting onboarding to completed.
class SetOnboardingToCompletedUseCase {
  final QuoteRepository quoteRepository;

  /// Creates a new SetOnboardingToCompletedUseCase instance.
  const SetOnboardingToCompletedUseCase(this.quoteRepository);

  /// Executes the use case to mark onboarding as completed.
  ///
  /// Returns: Either a failure or void on success
  Future<Either<Failure, void>> execute() {
    return quoteRepository.setOnboardingToCompleted();
  }
}
