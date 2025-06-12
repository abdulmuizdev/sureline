abstract class OnboardingNameState {
  const OnboardingNameState();
}

class Initial extends OnboardingNameState {}

class NameSaved extends OnboardingNameState {
  const NameSaved();
}

class GotName extends OnboardingNameState {
  final String name;
  const GotName(this.name);
}