import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_event.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_state.dart';

class OnboardingNameBloc
    extends Bloc<OnboardingNameEvent, OnboardingNameState> {
  final SharedPreferences prefs;

  OnboardingNameBloc(this.prefs) : super(Initial()) {
    on<OnContinuePressed>((event, emit) async {
      try {
        final result = await prefs.setString(SP.name, event.name);
        if (result) {
          emit(NameSaved());
        }
      } catch (e) {
        debugPrint('${e}');
      }
    });

    on<GetName>((event, emit) {
      try {
        final name = prefs.getString(SP.name) ?? '';
        debugPrint('name is this $name');
        emit(GotName(name));
      } catch (e) {
        debugPrint('${e}');
      }
    });
  }
}
