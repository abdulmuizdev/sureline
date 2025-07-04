import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/bloc/author_pref_event.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/bloc/author_pref_state.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/author_preferences/get_author_preferences_use_case.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/author_preferences/update_author_preference_use_case.dart';

class AuthorPrefBloc extends Bloc<AuthorPrefEvent, AuthorPrefState> {
  final GetAuthorPreferencesUseCase _getAuthorPreferencesUseCase;
  final UpdateAuthorPreferenceUseCase _updateAuthorPreferenceUseCase;

  AuthorPrefBloc(
    this._getAuthorPreferencesUseCase,
    this._updateAuthorPreferenceUseCase,
  ) : super(Initial()) {
    on<GetAuthorPrefOptions>((event, emit) async {
      debugPrint('got it');
      emit(GettingAuthorPrefOptions());
      final result = await _getAuthorPreferencesUseCase.call();
      result.fold((left) {}, (right) {
        debugPrint('right is this');
        emit(GotAuthorPrefOptions(right));
      });
    });

    on<OnAuthorPrefPressed>((event, emit) async {
      final result = await _updateAuthorPreferenceUseCase.call(
        event.authorPref.copyWith(isPreferred: !event.authorPref.isPreferred),
      );
      result.fold((left) {}, (right) async {
        add(GetAuthorPrefOptions());
      });
    });
  }
}
