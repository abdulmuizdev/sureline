import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/use_case/get_author_prefs_use_case.dart';
import 'package:sureline/features/general_settings/author_preferences/domain/use_case/update_author_prefs_use_case.dart';
import 'package:sureline/features/general_settings/author_preferences/presentation/bloc/author_pref_event.dart';
import 'package:sureline/features/general_settings/author_preferences/presentation/bloc/author_pref_state.dart';

class AuthorPrefBloc extends Bloc<AuthorPrefEvent, AuthorPrefState> {
  final GetAuthorPrefsUseCase _getAuthorPrefsUseCase;
  final UpdateAuthorPrefsUseCase _updateAuthorPrefsUseCase;

  AuthorPrefBloc(this._getAuthorPrefsUseCase, this._updateAuthorPrefsUseCase)
    : super(Initial()) {
    on<GetAuthorPrefOptions>((event, emit) {
      debugPrint('got it');
      emit(GettingAuthorPrefOptions());
      final result = _getAuthorPrefsUseCase.execute();
      result.fold((left) {}, (right) {
        debugPrint('right is this');
        emit(GotAuthorPrefOptions(right));
      });
    });

    on<OnAuthorPrefPressed>((event, emit) async {
      final result = await _updateAuthorPrefsUseCase.execute(event.authorPrefs);
      result.fold((left) {}, (right) {
        final authorPrefResult = _getAuthorPrefsUseCase.execute();
        authorPrefResult.fold((left) {}, (right) {
          emit(GotAuthorPrefOptions(right));
        });
      });
    });
  }
}
