import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/use_case/get_content_prefs_use_case.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/use_case/update_content_prefs_use_case.dart';
import 'package:sureline/features/general_settings/content_preferences/presentation/bloc/content_pref_event.dart';
import 'package:sureline/features/general_settings/content_preferences/presentation/bloc/content_pref_state.dart';

class ContentPrefBloc extends Bloc<ContentPrefEvent, ContentPrefState> {
  final GetContentPrefsUseCase _getContentPrefsUseCase;
  final UpdateContentPrefsUseCase _updateContentPrefsUseCase;

  ContentPrefBloc(this._getContentPrefsUseCase, this._updateContentPrefsUseCase)
    : super(Initial()) {
    on<GetContentPrefOptions>((event, emit) {
      debugPrint('got it');
      emit(GettingContentPrefOptions());
      final result = _getContentPrefsUseCase.execute();
      result.fold((left) {}, (right) {
        debugPrint('right is this');
        emit(GotContentPrefOptions(right));
      });
    });

    on<OnContentPrefPressed>((event, emit) async {
      final result = await _updateContentPrefsUseCase.execute(
        event.contentPrefs,
      );
      result.fold((left) {}, (right) {
        final contentPrefResult = _getContentPrefsUseCase.execute();
        contentPrefResult.fold((left) {}, (right) {
          emit(GotContentPrefOptions(right));
        });
      });
    });
  }
}
