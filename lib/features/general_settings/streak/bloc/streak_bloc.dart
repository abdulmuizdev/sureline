import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/features/general_settings/streak/bloc/streak_event.dart';
import 'package:sureline/features/general_settings/streak/bloc/streak_state.dart';

class StreakBloc extends Bloc<StreakEvent, StreakState> {
  final SharedPreferences prefs;

  StreakBloc(this.prefs) : super(Initial()) {
    on<GetStreakStatus>((event, emit) {
      try {
        final isEnabled = prefs.getBool(SP.streakEnable) ?? true;
        emit(GotStreakStatus(isEnabled));
      } catch (e) {
        debugPrint('${e}');
      }
    });

    on<UpdateStreakStatus>((event, emit) async {
      try {
        final isSuccessful = await prefs.setBool(
          SP.streakEnable,
          event.isEnabled,
        );
        if (isSuccessful) {
          final isEnabled = prefs.getBool(SP.streakEnable) ?? false;
          emit(StreakStatusUpdated(isEnabled));
        }
      } catch (e) {
        debugPrint('${e}');
      }
    });
  }
}
