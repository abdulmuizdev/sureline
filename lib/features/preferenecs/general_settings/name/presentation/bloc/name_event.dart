/// Abstract base class for all name-related events.
///
/// Events are dispatched to the NameBloc to trigger state changes
/// and business logic operations in the name settings feature.
/// This feature allows users to set and update their display name
/// which is used for personalization throughout the app.
abstract class NameEvent {
  const NameEvent();
}

/// Event triggered when user saves their name.
///
/// This event is dispatched when the user confirms their name input
/// in the name settings screen. The bloc will save the name to
/// persistent storage and emit NameSaved state to indicate success.
///
/// [name] - The name string to be saved
class OnSavePressed extends NameEvent {
  final String name;
  OnSavePressed(this.name);
}

/// Event to retrieve the current user's name.
///
/// This event triggers the loading of the user's saved name from
/// persistent storage. The bloc will emit GotName state with the
/// retrieved name, or an empty string if no name is saved.
class GetName extends NameEvent {
  const GetName();
}
