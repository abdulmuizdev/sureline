import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_event.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_state.dart';

/// Bloc for managing user name state during the onboarding process.
/// This bloc handles the persistence and retrieval of user names using
/// SharedPreferences, ensuring the name is available throughout the app.
///
/// The bloc coordinates between the UI and local storage, providing
/// proper state management for name input, validation, and persistence.
class OnboardingNameBloc extends Bloc<OnboardingNameEvent, OnboardingNameState> {
  /// SharedPreferences instance for persisting user name data.
  /// Used to save and retrieve the user's preferred name.
  final SharedPreferences prefs;

  /// Initializes the bloc with SharedPreferences dependency.
  /// Sets up event handlers for name persistence and retrieval.
  ///
  /// [prefs] - SharedPreferences instance for data persistence
  OnboardingNameBloc(this.prefs) : super(Initial()) {
    _setupEventHandlers();
  }

  /// Sets up event handlers for the bloc.
  /// Configures handlers for OnContinuePressed and GetName events.
  void _setupEventHandlers() {
    on<OnContinuePressed>(_handleOnContinuePressed);
    on<GetName>(_handleGetName);
  }

  /// Handles the OnContinuePressed event.
  /// Saves the user's name to SharedPreferences and emits NameSaved state.
  ///
  /// [event] - The OnContinuePressed event containing the user's name
  /// [emit] - Function to emit new states
  void _handleOnContinuePressed(OnContinuePressed event, Emitter<OnboardingNameState> emit) async {
    try {
      final result = await prefs.setString(SP.name, event.name);
      if (result) {
        emit(NameSaved());
      }
    } catch (e) {
      debugPrint('Error saving name: $e');
    }
  }

  /// Handles the GetName event.
  /// Retrieves the user's saved name from SharedPreferences and emits GotName state.
  ///
  /// [event] - The GetName event
  /// [emit] - Function to emit new states
  void _handleGetName(GetName event, Emitter<OnboardingNameState> emit) {
    try {
      final name = prefs.getString(SP.name) ?? '';
      debugPrint('Retrieved name: $name');
      emit(GotName(name));
    } catch (e) {
      debugPrint('Error retrieving name: $e');
    }
  }
}
