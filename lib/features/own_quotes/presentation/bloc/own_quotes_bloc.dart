import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/favourites/domain/use_cases/add_favourite_use_case.dart';
import 'package:sureline/features/favourites/domain/use_cases/remove_favourite_use_case.dart';
import 'package:sureline/features/own_quotes/domain/use_cases/add_own_quote_use_case.dart';
import 'package:sureline/features/own_quotes/domain/use_cases/get_all_own_quotes_use_case.dart';
import 'package:sureline/features/own_quotes/domain/use_cases/remove_own_quote_use_case.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_state.dart';

class OwnQuotesBloc extends Bloc<OwnQuotesEvent, OwnQuotesState> {
  final GetAllOwnQuotesUseCase _getAllOwnQuotesUseCase;
  final AddOwnQuoteUseCase _addOwnQuoteUseCase;
  final RemoveOwnQuoteUseCase _removeOwnQuoteUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  OwnQuotesBloc(
    this._getAllOwnQuotesUseCase,
    this._addOwnQuoteUseCase,
    this._removeOwnQuoteUseCase,
    this._addFavouriteUseCase,
    this._removeFavouriteUseCase,
  ) : super(Initial()) {
    on<GetOwnQuotes>((event, emit) async {
      await _getOwnQuotes(emit);
    });

    on<OnDeletePressed>((event, emit) async {
      final result = await _removeOwnQuoteUseCase.call(event.entity.id);
      await result.fold((left) {}, (right) async {
        await _getOwnQuotes(emit);
      });
    });

    on<OnLikePressed>((event, emit) async {
      HapticFeedback.lightImpact();
      if (event.isLiked) {
        await _addFavouriteUseCase.call(ownQuote: event.entity);
      } else {
        await _removeFavouriteUseCase.call(ownQuoteId: event.entity.id);
      }
      add(GetOwnQuotes());
    });

    on<SaveOwnQuote>((event, emit) async {
      final result = await _addOwnQuoteUseCase.call(event.entity);
      await result.fold((_) {}, (_) async {
        final updatedQuotesResult = await _getAllOwnQuotesUseCase.call();
        updatedQuotesResult.fold((left) {}, (right) {
          emit(SavedOwnQuote(right));
        });
      });
    });
  }
  Future<void> _getOwnQuotes(Emitter<OwnQuotesState> emit) async {
    final result = await _getAllOwnQuotesUseCase.call();
    result.fold((left) {}, (right) {
      emit(GotOwnQuotes(right));
    });
  }
}
