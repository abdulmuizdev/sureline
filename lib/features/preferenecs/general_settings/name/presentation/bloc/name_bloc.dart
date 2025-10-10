import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/features/preferenecs/general_settings/name/presentation/bloc/name_event.dart';
import 'package:sureline/features/preferenecs/general_settings/name/presentation/bloc/name_state.dart';

/// Bloc for managing name-related state and business logic.
///
/// This bloc handles all operations related to the user's display name,
/// including saving and retrieving the name from persistent storage.
/// It follows the Clean Architecture pattern by using SharedPreferences
/// for data persistence and emitting appropriate states for UI updates.
///
/// The bloc maintains the current state of the name settings and emits
/// appropriate states based on user actions and data operations.
class NameBloc extends Bloc<NameEvent, NameState> {
  final SharedPreferences prefs;

  /// Creates a new NameBloc instance.
  ///
  /// [prefs] - SharedPreferences instance for persistent storage
  NameBloc(this.prefs) : super(Initial()) {
    on<OnSavePressed>((event, emit) async {
      await _saveName(event.name, emit);
    });

    on<GetName>((event, emit) {
      _getName(emit);
    });
  }

  /// Saves the user's name to persistent storage.
  ///
  /// This method stores the provided name in SharedPreferences using
  /// the SP.name key. On successful save, it emits NameSaved state.
  /// On failure, it logs the error but maintains the current state.
  ///
  /// [name] - The name string to be saved
  /// [emit] - The emitter for state changes
  Future<void> _saveName(String name, Emitter<NameState> emit) async {
    try {
      final result = await prefs.setString(SP.name, name);
      if (result) {
        emit(NameSaved());
      }
    } catch (e) {
      debugPrint('${e}');
    }
  }

  /// Retrieves the user's name from persistent storage.
  ///
  /// This method loads the saved name from SharedPreferences using
  /// the SP.name key. It emits GotName state with the retrieved name,
  /// or an empty string if no name was previously saved.
  ///
  /// [emit] - The emitter for state changes
  void _getName(Emitter<NameState> emit) {
    try {
      final name = prefs.getString(SP.name) ?? '';
      emit(GotName(name));
    } catch (e) {
      debugPrint('${e}');
    }
  }
}
