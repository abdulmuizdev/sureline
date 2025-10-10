import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';

/// Base class for all icon-related events.
/// All events that can be dispatched to the IconBloc
/// must extend this class to ensure type safety.
abstract class IconEvent {
  const IconEvent();
}

/// Event to initialize the icon selection system.
/// This event triggers the loading of available app icons and
/// retrieves the currently selected icon state.
class Initialize extends IconEvent {
  const Initialize();
}

/// Event to change the current app icon.
/// This event triggers the application of a new app icon
/// throughout the system and updates the selection state.
///
/// [icon] - The icon entity to be applied as the new app icon
class ChangeIcon extends IconEvent {
  /// The icon entity to be applied as the new app icon.
  final IconEntity icon;

  const ChangeIcon(this.icon);
}
