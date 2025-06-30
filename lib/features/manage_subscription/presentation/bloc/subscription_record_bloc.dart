import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/manage_subscription/domain/use_cases/get_subscription_records_use_case.dart';
import 'package:sureline/features/manage_subscription/presentation/bloc/subscription_record_event.dart';
import 'package:sureline/features/manage_subscription/presentation/bloc/subscription_record_state.dart';

class SubscriptionRecordBloc
    extends Bloc<SubscriptionRecordEvent, SubscriptionRecordState> {
  final GetSubscriptionRecordsUseCase getSubscriptionRecordsUseCase;

  SubscriptionRecordBloc({required this.getSubscriptionRecordsUseCase})
    : super(SubscriptionRecordInitial()) {
    on<GetSubscriptionRecordsEvent>(_onGetSubscriptionRecords);
  }

  Future<void> _onGetSubscriptionRecords(
    GetSubscriptionRecordsEvent event,
    Emitter<SubscriptionRecordState> emit,
  ) async {
    emit(SubscriptionRecordLoading());
    final result = await getSubscriptionRecordsUseCase.execute();
    result.fold(
      (failure) => emit(SubscriptionRecordError(message: failure.message)),
      (subscriptionRecords) => emit(
        SubscriptionRecordLoaded(subscriptionRecords: subscriptionRecords),
      ),
    );
  }
}
