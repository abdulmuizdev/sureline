import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/common/domain/use_cases/favourites/add_favourite_use_case.dart';
import 'package:sureline/common/domain/use_cases/favourites/remove_favourite_use_case.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/use_cases/add_own_quote_use_case.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/use_cases/get_all_own_quotes_use_case.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/use_cases/remove_own_quote_use_case.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_state.dart';

/// Bloc for managing own quotes-related state and business logic.
///
/// This bloc handles all operations related to user's custom quotes,
/// including creating, retrieving, deleting, and favouriting own quotes.
/// It follows the Clean Architecture pattern by delegating business logic
/// to use cases.
///
/// The bloc maintains the current state of own quotes and handles
/// user interactions like creating new quotes, deleting quotes, and
/// favouriting quotes with haptic feedback for better user experience.
class OwnQuotesBloc extends Bloc<OwnQuotesEvent, OwnQuotesState> {
  final GetAllOwnQuotesUseCase _getAllOwnQuotesUseCase;
  final AddOwnQuoteUseCase _addOwnQuoteUseCase;
  final RemoveOwnQuoteUseCase _removeOwnQuoteUseCase;
  final AddFavouriteUseCase _addFavouriteUseCase;
  final RemoveFavouriteUseCase _removeFavouriteUseCase;

  /// Creates a new OwnQuotesBloc instance.
  ///
  /// [getAllOwnQuotesUseCase] - Use case for retrieving all own quotes
  /// [addOwnQuoteUseCase] - Use case for adding new own quotes
  /// [removeOwnQuoteUseCase] - Use case for removing own quotes
  /// [addFavouriteUseCase] - Use case for adding quotes to favourites
  /// [removeFavouriteUseCase] - Use case for removing quotes from favourites
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
      await _handleDeletePressed(event, emit);
    });

    on<OnLikePressed>((event, emit) async {
      await _handleLikePressed(event, emit);
    });

    on<SaveOwnQuote>((event, emit) async {
      await _handleSaveOwnQuote(event, emit);
    });
  }

  /// Retrieves own quotes and emits the appropriate state.
  ///
  /// This method calls the get all own quotes use case and handles the result.
  /// On success, it emits GotOwnQuotes with the retrieved quotes.
  /// On failure, it maintains the current state (error handling could be
  /// enhanced to emit specific error states).
  ///
  /// [emit] - The emitter for state changes
  Future<void> _getOwnQuotes(Emitter<OwnQuotesState> emit) async {
    final result = await _getAllOwnQuotesUseCase.call();
    result.fold((left) {}, (right) {
      emit(GotOwnQuotes(right));
    });
  }

  /// Handles the delete action for an own quote.
  ///
  /// This method calls the remove own quote use case and refreshes
  /// the list after successful deletion.
  ///
  /// [event] - The OnDeletePressed event containing the entity to delete
  /// [emit] - The emitter for state changes
  Future<void> _handleDeletePressed(OnDeletePressed event, Emitter<OwnQuotesState> emit) async {
    final result = await _removeOwnQuoteUseCase.call(event.entity.id);
    await result.fold((left) {}, (right) async {
      await _getOwnQuotes(emit);
    });
  }

  /// Handles the like/unlike action for an own quote.
  ///
  /// This method provides haptic feedback and updates the favourite
  /// status of the own quote. It then refreshes the own quotes list.
  ///
  /// [event] - The OnLikePressed event containing the entity and new status
  /// [emit] - The emitter for state changes
  Future<void> _handleLikePressed(OnLikePressed event, Emitter<OwnQuotesState> emit) async {
    HapticFeedback.lightImpact();
    if (event.isLiked) {
      await _addFavouriteUseCase.call(ownQuote: event.entity);
    } else {
      await _removeFavouriteUseCase.call(ownQuoteId: event.entity.id);
    }
    add(GetOwnQuotes());
  }

  /// Handles saving a new own quote.
  ///
  /// This method calls the add own quote use case and refreshes
  /// the list to include the new quote. It emits both SavedOwnQuote
  /// and GotOwnQuotes states for proper UI updates.
  ///
  /// [event] - The SaveOwnQuote event containing the entity to save
  /// [emit] - The emitter for state changes
  Future<void> _handleSaveOwnQuote(SaveOwnQuote event, Emitter<OwnQuotesState> emit) async {
    final result = await _addOwnQuoteUseCase.call(event.entity);
    await result.fold((_) {}, (_) async {
      final updatedQuotesResult = await _getAllOwnQuotesUseCase.call();
      updatedQuotesResult.fold((left) {}, (right) {
        emit(SavedOwnQuote(right));
        emit(GotOwnQuotes(right)); // Emit GotOwnQuotes for list page rebuild
      });
    });
  }
}
