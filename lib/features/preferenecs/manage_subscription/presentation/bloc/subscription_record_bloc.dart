import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/use_cases/get_subscription_records_use_case.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/bloc/subscription_record_event.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/bloc/subscription_record_state.dart';

/// Bloc for managing subscription record-related state and operations.
///
/// This bloc handles all operations related to subscription management,
/// including retrieving subscription records and managing subscription
/// status. It follows the Clean Architecture pattern by delegating
/// business logic to use cases.
///
/// The bloc maintains the current state of subscription records and
/// handles loading subscription data for display in the UI.
class SubscriptionRecordBloc extends Bloc<SubscriptionRecordEvent, SubscriptionRecordState> {
  final GetSubscriptionRecordsUseCase getSubscriptionRecordsUseCase;

  /// Creates a new SubscriptionRecordBloc instance.
  ///
  /// [getSubscriptionRecordsUseCase] - Use case for retrieving subscription records
  SubscriptionRecordBloc({required this.getSubscriptionRecordsUseCase})
    : super(const SubscriptionRecordInitial()) {
    on<GetSubscriptionRecordsEvent>(_onGetSubscriptionRecords);
  }

  /// Handles the GetSubscriptionRecordsEvent to load subscription data.
  ///
  /// This method calls the get subscription records use case and handles
  /// the result. On success, it emits SubscriptionRecordLoaded with the
  /// retrieved records. On failure, it emits SubscriptionRecordError with
  /// the error message.
  ///
  /// [event] - The GetSubscriptionRecordsEvent to process
  /// [emit] - The emitter for state changes
  Future<void> _onGetSubscriptionRecords(
    GetSubscriptionRecordsEvent event,
    Emitter<SubscriptionRecordState> emit,
  ) async {
    emit(const SubscriptionRecordLoading());
    final result = await getSubscriptionRecordsUseCase.execute();
    result.fold(
      (failure) => emit(SubscriptionRecordError(message: failure.message)),
      (subscriptionRecords) =>
          emit(SubscriptionRecordLoaded(subscriptionRecords: subscriptionRecords)),
    );
  }
}
