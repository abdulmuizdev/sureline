/// Abstract base class for all name-related states.
///
/// States represent the different UI states that the name settings feature
/// can be in, from initial loading to displaying data or indicating
/// successful save operations.
abstract class NameState {
  const NameState();
}

/// Initial state when the name settings feature is first loaded.
///
/// This state is emitted when the NameBloc is first created
/// and no data has been loaded yet. The UI should show a loading
/// indicator or empty input field.
class Initial extends NameState {}

/// State when the name has been successfully saved.
///
/// This state is emitted after successfully saving the user's name
/// to persistent storage. The UI should typically close the settings
/// screen or show a success indicator.
class NameSaved extends NameState {
  const NameSaved();
}

/// State when the current user's name has been retrieved.
///
/// This state is emitted after successfully loading the user's
/// saved name from persistent storage. The UI should populate
/// the input field with the retrieved name.
///
/// [name] - The retrieved name string (empty if no name was saved)
class GotName extends NameState {
  final String name;
  const GotName(this.name);
}
