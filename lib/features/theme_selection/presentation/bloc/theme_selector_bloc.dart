import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/use_cases/change_theme_use_case.dart';
import 'package:sureline/features/theme_selection/domain/use_case/get_theme_mixes_use_case.dart';
import 'package:sureline/features/theme_selection/domain/use_case/get_themes_use_case.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_event.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_state.dart';

class ThemeSelectorBloc extends Bloc<ThemeSelectorEvent, ThemeSelectorState> {
  final GetThemesUseCase _getThemesUseCase;
  final GetThemeMixesUseCase _getThemeMixesUseCase;
  final ChangeThemeUseCase _changeThemeUseCase;

  ThemeSelectorBloc(
    this._getThemesUseCase,
    this._getThemeMixesUseCase,
    this._changeThemeUseCase,
  ) : super(Initial()) {
    on<GetThemes>((event, emit) async {
      emit(GettingThemes());
      final result = await _getThemesUseCase.execute();
      result.fold((left) {}, (right) {
        final activeIndex = right.indexWhere(
          (entity) => entity.isActive == true,
        );
        emit(GotThemes(right, activeIndex));
      });
    });

    on<GetThemeMixes>((event, emit) async {
      emit(GettingThemeMixes());
      final result = await _getThemeMixesUseCase.execute();
      result.fold((left) {}, (right) {
        emit(GotThemeMixes(right));
      });
    });

    on<ChangeTheme>((event, emit) async {
      emit(ChangingTheme());
      HapticFeedback.lightImpact();
      print(
        'change theme is called in bloc with font size ${event.entity.textDecorEntity.fontSize}',
      );
      final result = await _changeThemeUseCase.execute(event.entity);
      result.fold((left) {}, (right) {
        emit(ChangedTheme());
      });
    });
  }
}
