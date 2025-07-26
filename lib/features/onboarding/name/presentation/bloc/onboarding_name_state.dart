/// Base class for all onboarding name states.
/// All states that can be emitted by the OnboardingNameBloc
/// must extend this class to ensure type safety.
abstract class OnboardingNameState {
  const OnboardingNameState();
}

/// Initial state when the name onboarding feature is first loaded.
/// This state is emitted before any name data is loaded or operations are performed.
class Initial extends OnboardingNameState {}

/// State emitted when the user's name has been successfully saved.
/// This state indicates that the name persistence operation completed
/// and the user can proceed to the next onboarding step.
class NameSaved extends OnboardingNameState {
  const NameSaved();
}

/// State emitted when the user's previously saved name has been retrieved.
/// This state contains the name data that was loaded from storage
/// and can be displayed in the UI.
///
/// [name] - The user's saved name retrieved from storage
class GotName extends OnboardingNameState {
  /// The user's saved name retrieved from storage.
  final String name;

  const GotName(this.name);
}
