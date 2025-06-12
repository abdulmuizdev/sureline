import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/constants/sureline_themes.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_event.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  ThemeBloc() : super(Initial()) {
    on<GetThemes>((event, emit) {
      final themes = SurelineThemes.values;
      emit(GotThemes(themes));
    });
  }
}
