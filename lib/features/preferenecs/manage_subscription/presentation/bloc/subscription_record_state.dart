import 'package:sureline/features/preferenecs/manage_subscription/domain/entity/subscription_record_entity.dart';

/// Abstract base class for all subscription record states.
///
/// States represent the different UI states that the subscription management
/// feature can be in, from initial loading to displaying data or error states.
abstract class SubscriptionRecordState {
  const SubscriptionRecordState();
}

/// Initial state when the subscription management feature is first loaded.
///
/// This state is emitted when the SubscriptionRecordBloc is first created
/// and no data has been loaded yet. The UI should show a loading
/// indicator or empty state.
class SubscriptionRecordInitial extends SubscriptionRecordState {
  const SubscriptionRecordInitial();
}

/// State when subscription records are being loaded.
///
/// This state is emitted while the bloc is fetching subscription
/// records from the data source. The UI should show a loading
/// indicator during this operation.
class SubscriptionRecordLoading extends SubscriptionRecordState {
  const SubscriptionRecordLoading();
}

/// State when subscription records have been successfully loaded.
///
/// This state is emitted after successfully retrieving subscription
/// records from the data source. The UI should display the list
/// of subscription records with appropriate information.
///
/// [subscriptionRecords] - List of subscription record entities to display
class SubscriptionRecordLoaded extends SubscriptionRecordState {
  final List<SubscriptionRecordEntity> subscriptionRecords;

  const SubscriptionRecordLoaded({required this.subscriptionRecords});
}

/// State when an error occurs during subscription record operations.
///
/// This state is emitted when an error occurs while retrieving
/// subscription records. The UI should display an appropriate
/// error message to the user.
///
/// [message] - Error message describing what went wrong
class SubscriptionRecordError extends SubscriptionRecordState {
  final String message;

  const SubscriptionRecordError({required this.message});
}
