/// Domain entity representing a subscription record.
class SubscriptionRecordEntity {
  /// The title of the subscription record.
  final String title;

  /// The date of the subscription record.
  final DateTime date;

  /// Creates a new SubscriptionRecordEntity instance.
  const SubscriptionRecordEntity({required this.title, required this.date});
}
