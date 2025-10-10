import 'package:sureline/features/preferenecs/manage_subscription/domain/entity/subscription_record_entity.dart';

/// Data model representing a subscription record with JSON serialization capabilities.
class SubscriptionRecordModel extends SubscriptionRecordEntity {
  /// Creates a new SubscriptionRecordModel instance.
  const SubscriptionRecordModel({required super.title, required super.date});

  /// Creates a SubscriptionRecordModel from a JSON map.
  factory SubscriptionRecordModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionRecordModel(
      title: json['title']?.toString() ?? '',
      date: DateTime.parse(json['date']?.toString() ?? ''),
    );
  }
}
