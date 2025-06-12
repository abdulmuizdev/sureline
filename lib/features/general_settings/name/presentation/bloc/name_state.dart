abstract class NameState {
  const NameState();
}

class Initial extends NameState {}

class NameSaved extends NameState {
  const NameSaved();
}

class GotName extends NameState {
  final String name;
  const GotName(this.name);
}