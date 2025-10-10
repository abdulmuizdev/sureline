/// Use case for checking if a streak entry can be logged.
///
/// This use case handles the business logic for determining
/// whether a user can log a new streak entry based on timing rules.
class CanLogStreakEntryUseCase {
  /// Creates an instance of [CanLogStreakEntryUseCase].
  const CanLogStreakEntryUseCase();

  /// Executes the use case to check if streak entry can be logged.
  ///
  /// Returns [bool] indicating whether logging is allowed.
  bool execute({required DateTime? lastCheckIn, DateTime? now}) {
    if (lastCheckIn == null) {
      return true;
    }
    final currentDate = now ?? DateTime.now();
    final diff = currentDate.difference(lastCheckIn);
    return diff > const Duration(hours: 24);
  }
}
