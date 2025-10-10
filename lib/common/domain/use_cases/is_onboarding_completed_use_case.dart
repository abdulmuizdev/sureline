/// Onboarding completion check use cases for the Sureline app.
///
/// This file contains the use case for checking onboarding completion
/// status within the Sureline app. The [IsOnboardingCompletedUseCase]
/// encapsulates the business logic for determining whether the user
/// has completed the onboarding process.
///
/// Key Features:
/// - Clean Architecture use case pattern
/// - Dependency injection with repository
/// - Functional error handling with Either
/// - Boolean result for completion status
///
/// Usage:
/// ```dart
/// final useCase = IsOnboardingCompletedUseCase(quoteRepository);
/// final result = await useCase.execute();
/// result.fold(
///   (failure) => handleError(failure),
///   (isCompleted) => handleCompletionStatus(isCompleted),
/// );
/// ```

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

import 'package:sureline/features/home/domain/repository/quote_repository.dart';

/// Use case for checking if onboarding is completed.
///
/// This use case handles the business logic for determining
/// whether the user has completed the onboarding process. It follows
/// the Clean Architecture pattern by encapsulating the business rules
/// and delegating data operations to the repository layer.
///
/// Responsibilities:
/// - Check onboarding completion status
/// - Coordinate with quote repository
/// - Handle success and failure scenarios
/// - Provide clean interface for presentation layer
///
/// Dependencies:
/// - [QuoteRepository]: For checking onboarding status
///
/// Returns: [Either<Failure, bool>] indicating completion status or failure
class IsOnboardingCompletedUseCase {
  /// The quote repository dependency.
  ///
  /// Used to check the onboarding completion status from persistent storage.
  final QuoteRepository quoteRepository;

  /// Creates an instance of [IsOnboardingCompletedUseCase].
  ///
  /// [quoteRepository]: The quote repository for checking onboarding status
  const IsOnboardingCompletedUseCase(this.quoteRepository);

  /// Executes the use case to check onboarding completion status.
  ///
  /// This method encapsulates the business logic for determining
  /// whether the user has completed the onboarding process. It delegates
  /// the actual status check to the repository and returns a functional
  /// result indicating the completion status or failure.
  ///
  /// Returns: [Either<Failure, bool>] indicating completion status or failure
  /// - Success: true if onboarding is completed, false otherwise
  /// - Failure: if there was an error checking the status
  ///
  /// Example:
  /// ```dart
  /// final result = await useCase.execute();
  /// result.fold(
  ///   (failure) => print('Failed to check onboarding: ${failure.message}'),
  ///   (isCompleted) => print('Onboarding completed: $isCompleted'),
  /// );
  /// ```
  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isOnboardingComplete();
  }
}
