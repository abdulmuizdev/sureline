import 'package:flutter_app_icon_changer/flutter_app_icon_changer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/constants/sureline_icons.dart';
import 'package:sureline/common/presentation/bloc/icon_event.dart';
import 'package:sureline/common/presentation/bloc/icon_state.dart';

/// Bloc for managing app icon selection and changes throughout the app.
/// This bloc handles the initialization of available icons, current icon detection,
/// and the process of changing the app icon using the FlutterAppIconChangerPlugin.
///
/// The bloc coordinates between the UI and the native icon change plugin,
/// providing proper state management for icon operations across the app.
class IconBloc extends Bloc<IconEvent, IconState> {
  /// Plugin dependency for native app icon change functionality.
  /// Provides the interface to change app icons on supported devices.
  final FlutterAppIconChangerPlugin plugin;

  /// Initializes the bloc with the required plugin dependency.
  /// Sets up event handlers for icon initialization and changes.
  ///
  /// [plugin] - The FlutterAppIconChangerPlugin for native icon operations
  IconBloc(this.plugin) : super(Initial()) {
    _setupEventHandlers();
  }

  /// Sets up event handlers for all icon-related events.
  /// Configures handlers for initialization and icon changes.
  void _setupEventHandlers() {
    on<Initialize>(_handleInitialize);
    on<ChangeIcon>(_handleChangeIcon);
  }

  /// Handles the Initialize event.
  /// Checks device support, retrieves current icon, and loads available icons.
  ///
  /// [event] - The Initialize event
  /// [emit] - Function to emit new states
  void _handleInitialize(Initialize event, Emitter<IconState> emit) async {
    emit(Initializing());

    if (await plugin.isSupported()) {
      final currentIcon = await plugin.getCurrentIcon() ?? plugin.iconsSet.first.iOSIcon;
      final selectedIndex = plugin.iconsSet.indexWhere((icon) => icon.iOSIcon == currentIcon);

      emit(Initialized(SurelineIcons.values, selectedIndex));
    } else {
      emit(IconError('Icon change is not supported on this device'));
    }
  }

  /// Handles the ChangeIcon event.
  /// Checks if the icon is already active, then attempts to change the app icon.
  ///
  /// [event] - The ChangeIcon event containing the icon to apply
  /// [emit] - Function to emit new states
  void _handleChangeIcon(ChangeIcon event, Emitter<IconState> emit) async {
    emit(ChangingIcon());

    // Check if the icon is already the current icon
    if (await plugin.getCurrentIcon() == event.icon.iOSIcon) {
      return emit(ChangedIcon());
    }

    final currentIcon = event.icon.currentIcon;
    try {
      final result = await plugin.changeIcon(currentIcon);

      if (result ?? false) {
        emit(ChangedIcon());
      } else {
        emit(IconError('Unable to change icon'));
      }
    } catch (e) {
      emit(IconError(e.toString()));
    }
  }
}
