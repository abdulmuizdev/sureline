import 'package:sureline/features/manage_subscription/domain/entity/subscription_record_entity.dart';

class SubscriptionRecordModel extends SubscriptionRecordEntity {
  SubscriptionRecordModel({required super.title, required super.date});

  factory SubscriptionRecordModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionRecordModel(
      title: json['title'],
      date: DateTime.parse(json['date']),
    );
  }
}
