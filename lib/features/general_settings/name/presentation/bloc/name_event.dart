abstract class NameEvent {
  const NameEvent();
}

class OnSavePressed extends NameEvent {
  final String name;
  OnSavePressed(this.name);
}

class GetName extends NameEvent {
  const GetName();
}