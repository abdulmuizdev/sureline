import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/change_theme_use_case.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_event.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_state.dart';
import 'package:sureline/features/theme_selection/domain/use_case/get_themes_use_case.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ChangeThemeUseCase _changeThemeUseCase;
  final GetThemesUseCase _getThemesUseCase;
  ThemeBloc(this._changeThemeUseCase, this._getThemesUseCase)
    : super(Initial()) {
    on<GetThemes>((event, emit) async {
      final result = await _getThemesUseCase.execute();
      result.fold((left) {}, (right) {
        emit(
          GotThemes(
            right.reversed.toList(),
            (right.reversed.toList()).indexWhere((theme) => theme.isActive),
          ),
        );
      });
    });

    on<ChangeTheme>((event, emit) async {
      emit(ChangingTheme());
      HapticFeedback.lightImpact();

      final result = await _changeThemeUseCase.execute(event.entity);
      result.fold((left) {}, (right) {
        // emit(ChangedTheme());
        add(GetThemes());
      });
    });
  }
}
