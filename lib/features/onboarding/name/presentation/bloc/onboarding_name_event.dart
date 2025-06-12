abstract class OnboardingNameEvent {
  const OnboardingNameEvent();
}

class OnContinuePressed extends OnboardingNameEvent {
  final String name;
  OnContinuePressed(this.name);
}

class GetName extends OnboardingNameEvent {
  const GetName();
}