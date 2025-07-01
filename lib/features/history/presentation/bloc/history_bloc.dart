import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/favourites/domain/use_cases/add_favourite_use_case.dart';
import 'package:sureline/features/favourites/domain/use_cases/remove_favourite_use_case.dart';
import 'package:sureline/features/history/domain/use_cases/get_history_use_case.dart';
import 'package:sureline/features/history/presentation/bloc/history_event.dart';
import 'package:sureline/features/history/presentation/bloc/history_state.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/get_shown_quotes_use_case.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryUseCase getHistoryUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  HistoryBloc(
    this.getHistoryUseCase,
    this._addFavouriteUseCase,
    this._removeFavouriteUseCase,
  ) : super(HistoryInitial()) {
    on<GetHistory>((event, emit) async {
      final result = await getHistoryUseCase.call();
      result.fold(
        (l) => emit(HistoryError(l.message)),
        (r) => emit(HistoryLoaded(r)),
      );
    });
    on<OnLikePressed>((event, emit) async {
      HapticFeedback.lightImpact();
      print('isLiked: ${event.isLiked}');
      if (event.isLiked) {
        await _addFavouriteUseCase.call(history: event.entity);
      } else {
        await _removeFavouriteUseCase.call(historyId: event.entity.id);
      }
      add(GetHistory());
    });
  }
}
