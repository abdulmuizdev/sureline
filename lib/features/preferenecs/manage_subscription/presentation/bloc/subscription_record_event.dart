/// Abstract base class for all subscription record events.
///
/// Events are dispatched to the SubscriptionRecordBloc to trigger state changes
/// and business logic operations in the subscription management feature.
/// This feature allows users to view their subscription status and history.
abstract class SubscriptionRecordEvent {
  const SubscriptionRecordEvent();
}

/// Event to retrieve subscription records from the data source.
///
/// This event triggers the loading of all subscription-related records,
/// including current subscription status and historical subscription data.
/// The bloc will emit SubscriptionRecordLoaded state with the retrieved records.
class GetSubscriptionRecordsEvent extends SubscriptionRecordEvent {
  const GetSubscriptionRecordsEvent();
}
