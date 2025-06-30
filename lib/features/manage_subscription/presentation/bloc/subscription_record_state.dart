import 'package:sureline/features/manage_subscription/domain/entity/subscription_record_entity.dart';

abstract class SubscriptionRecordState {}

class SubscriptionRecordInitial extends SubscriptionRecordState {}

class SubscriptionRecordLoading extends SubscriptionRecordState {}

class SubscriptionRecordLoaded extends SubscriptionRecordState {
  final List<SubscriptionRecordEntity> subscriptionRecords;

  SubscriptionRecordLoaded({required this.subscriptionRecords});
}

class SubscriptionRecordError extends SubscriptionRecordState {
  final String message;

  SubscriptionRecordError({required this.message});
}
