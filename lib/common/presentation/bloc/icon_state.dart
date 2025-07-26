import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';

/// Base class for all icon-related states.
/// All states that can be emitted by the IconBloc
/// must extend this class to ensure type safety.
abstract class IconState {
  const IconState();
}

/// Initial state when the icon selection feature is first loaded.
/// This state is emitted before any icon data is loaded or operations are performed.
class Initial extends IconState {
  const Initial();
}

/// State emitted while the icon system is being initialized.
/// This state indicates that icon data is being loaded and the UI should show
/// appropriate loading indicators.
class Initializing extends IconState {
  const Initializing();
}

/// State emitted when the icon system has been successfully initialized.
/// This state contains the available icons and the currently selected icon index.
///
/// [icons] - The list of available app icons
/// [selectedIndex] - The index of the currently selected icon
class Initialized extends IconState {
  /// The list of available app icons retrieved from the data source.
  final List<IconEntity> icons;

  /// The index of the currently selected icon in the icons list.
  final int selectedIndex;

  const Initialized(this.icons, this.selectedIndex);
}

/// State emitted while an icon change operation is in progress.
/// This state indicates that the app icon is currently being changed
/// and the UI should show appropriate feedback.
class ChangingIcon extends IconState {
  const ChangingIcon();
}

/// State emitted when an icon change has been successfully completed.
/// This state indicates that the new app icon has been applied
/// throughout the system and the selection has been updated.
class ChangedIcon extends IconState {
  const ChangedIcon();
}

/// State emitted when an error occurs during icon operations.
/// This state contains error information for debugging and user feedback.
///
/// [message] - The error message describing what went wrong
class IconError extends IconState {
  /// The error message describing what went wrong during the operation.
  final String message;

  const IconError(this.message);
}
