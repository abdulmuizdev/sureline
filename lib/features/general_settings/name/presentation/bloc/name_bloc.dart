import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/features/general_settings/name/presentation/bloc/name_event.dart';
import 'package:sureline/features/general_settings/name/presentation/bloc/name_state.dart';

class NameBloc extends Bloc<NameEvent, NameState> {
  final SharedPreferences prefs;

  NameBloc(this.prefs) : super(Initial()) {
    on<OnSavePressed>((event, emit) async {
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
        emit(GotName(name));
      } catch (e) {
        debugPrint('${e}');
      }
    });
  }
}
