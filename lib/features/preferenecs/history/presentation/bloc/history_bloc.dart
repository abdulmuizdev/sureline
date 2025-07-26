import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/favourites/add_favourite_use_case.dart';
import 'package:sureline/common/domain/use_cases/favourites/remove_favourite_use_case.dart';
import 'package:sureline/features/preferenecs/history/domain/use_cases/get_history_use_case.dart';
import 'package:sureline/features/preferenecs/history/presentation/bloc/history_event.dart';
import 'package:sureline/features/preferenecs/history/presentation/bloc/history_state.dart';

/// Bloc for managing history-related state and business logic.
///
/// This bloc handles all operations related to user's browsing history,
/// including loading history records and managing favourite status
/// of history items. It follows the Clean Architecture pattern by
/// delegating business logic to use cases.
///
/// The bloc maintains the current state of history and handles
/// user interactions like favouriting/unfavouriting history items
/// with haptic feedback for better user experience.
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryUseCase getHistoryUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  /// Creates a new HistoryBloc instance.
  ///
  /// [getHistoryUseCase] - Use case for retrieving history records
  /// [addFavouriteUseCase] - Use case for adding items to favourites
  /// [removeFavouriteUseCase] - Use case for removing items from favourites
  HistoryBloc(this.getHistoryUseCase, this._addFavouriteUseCase, this._removeFavouriteUseCase)
    : super(HistoryInitial()) {
    on<GetHistory>((event, emit) async {
      await _getHistory(emit);
    });
    on<OnLikePressed>((event, emit) async {
      await _handleLikePressed(event, emit);
    });
  }

  /// Retrieves history records and emits the appropriate state.
  ///
  /// This method calls the get history use case and handles the result.
  /// On success, it emits HistoryLoaded with the retrieved history.
  /// On failure, it emits HistoryError with the error message.
  ///
  /// [emit] - The emitter for state changes
  Future<void> _getHistory(Emitter<HistoryState> emit) async {
    final result = await getHistoryUseCase.call(isPremium: false);
    result.fold((l) => emit(HistoryError(l.message)), (r) => emit(HistoryLoaded(r)));
  }

  /// Handles the like/unlike action for a history item.
  ///
  /// This method provides haptic feedback and updates the favourite
  /// status of the history item. It then refreshes the history
  /// list to reflect the changes.
  ///
  /// [event] - The OnLikePressed event containing the entity and new status
  /// [emit] - The emitter for state changes
  Future<void> _handleLikePressed(OnLikePressed event, Emitter<HistoryState> emit) async {
    HapticFeedback.lightImpact();
    print('isLiked: ${event.isLiked}');
    if (event.isLiked) {
      await _addFavouriteUseCase.call(history: event.entity);
    } else {
      await _removeFavouriteUseCase.call(historyId: event.entity.id);
    }
    add(GetHistory());
  }
}
