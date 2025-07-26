/// Notification scheduling use cases for the Sureline app.
///
/// This file contains the use case for scheduling notifications
/// within the Sureline app. The [ScheduleUpToSixtyNotificationsUseCase]
/// encapsulates the business logic for scheduling up to sixty
/// notification reminders for the user.
///
/// Key Features:
/// - Clean Architecture use case pattern
/// - Dependency injection with repository
/// - Functional error handling with Either
/// - Bulk notification scheduling
///
/// Usage:
/// ```dart
/// final useCase = ScheduleUpToSixtyNotificationsUseCase(notificationRepository);
/// final result = await useCase.execute();
/// result.fold(
///   (failure) => handleError(failure),
///   (_) => handleSuccess(),
/// );
/// ```

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';

import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';

/// Use case for scheduling up to sixty notifications.
///
/// This use case handles the business logic for scheduling
/// notification reminders for the user. It follows the Clean
/// Architecture pattern by encapsulating the business rules and
/// delegating the actual scheduling to the repository layer.
///
/// Responsibilities:
/// - Schedule up to sixty notification reminders
/// - Coordinate with notification settings repository
/// - Handle success and failure scenarios
/// - Provide clean interface for presentation layer
///
/// Dependencies:
/// - [NotificationSettingRepository]: For notification scheduling operations
///
/// Returns: [Either<Failure, void>] indicating success or failure
class ScheduleUpToSixtyNotificationsUseCase {

  /// Creates an instance of [ScheduleUpToSixtyNotificationsUseCase].
  ///
  /// [repository]: The notification settings repository for scheduling operations
  const ScheduleUpToSixtyNotificationsUseCase(this.repository);
  /// The notification settings repository dependency.
  ///
  /// Used to schedule notification reminders in the system.
  final NotificationSettingRepository repository;

  /// Executes the use case to schedule notifications.
  ///
  /// This method encapsulates the business logic for scheduling
  /// up to sixty notification reminders for the user. It delegates
  /// the actual scheduling to the repository and returns a functional
  /// result indicating success or failure.
  ///
  /// Returns: [Either<Failure, void>] indicating success or failure
  /// - Success: when notifications are scheduled successfully
  /// - Failure: if there was an error scheduling the notifications
  ///
  /// Example:
  /// ```dart
  /// final result = await useCase.execute();
  /// result.fold(
  ///   (failure) => print('Failed to schedule notifications: ${failure.message}'),
  ///   (_) => print('Notifications scheduled successfully'),
  /// );
  /// ```
  Future<Either<Failure, void>> execute() {
    return repository.scheduleUpToSixtyNotifications();
  }
}
