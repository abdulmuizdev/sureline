/// Base class for all onboarding name events.
/// All events that can be dispatched to the OnboardingNameBloc
/// must extend this class to ensure type safety.
abstract class OnboardingNameEvent {
  const OnboardingNameEvent();
}

/// Event dispatched when the user presses the continue button with a name.
/// This event triggers the saving of the user's name and navigation to
/// the next onboarding step.
///
/// [name] - The name entered by the user
class OnContinuePressed extends OnboardingNameEvent {
  /// The name entered by the user to be saved.
  final String name;

  OnContinuePressed(this.name);
}

/// Event to retrieve the user's previously saved name.
/// This event is dispatched to load any existing name data
/// when the screen is initialized.
class GetName extends OnboardingNameEvent {
  const GetName();
}
