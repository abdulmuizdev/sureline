import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/bloc/icon_bloc.dart';
import 'package:sureline/common/presentation/bloc/icon_event.dart';
import 'package:sureline/common/presentation/bloc/icon_state.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/app_icon_selection/presentation/bottom_sheet/widgets/icon_setting_grid_item.dart';
import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';

/// Bottom sheet for selecting and changing the app icon in preferences.
/// This component provides a grid interface for users to choose from available
/// app icon options and apply their selection to change the app's appearance.
///
/// The bottom sheet includes state management for icon selection, visual feedback,
/// and integration with the icon change system throughout the app.
class AppIconSettingBottomSheet extends StatefulWidget {
  const AppIconSettingBottomSheet({super.key});

  @override
  State<AppIconSettingBottomSheet> createState() => _AppIconSettingBottomSheetState();
}

class _AppIconSettingBottomSheetState extends State<AppIconSettingBottomSheet> {
  /// List of available app icons retrieved from the bloc.
  /// Populated when the Initialized state is received.
  List<IconEntity> _icons = [];

  /// Index of the currently selected app icon in the grid.
  /// Null indicates no selection, valid indices correspond to icon array positions.
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<IconBloc>()..add(const Initialize()))],
      child: BlocListener<IconBloc, IconState>(
        listener: (context, state) {
          _handleStateChanges(state);
        },
        child: BlocBuilder<IconBloc, IconState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  Expanded(child: _buildIconGrid()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Handles state changes from the IconBloc.
  /// Updates local state when icons are loaded, selection changes, or errors occur.
  ///
  /// [state] - The current state from the bloc
  void _handleStateChanges(IconState state) {
    if (state is ChangedIcon) {
      // Refresh the icon list after a successful change
      context.read<IconBloc>().add(const Initialize());
    }
    if (state is Initialized) {
      setState(() {
        _selectedIndex = state.selectedIndex;
        _icons = state.icons;
      });
    }
    if (state is IconError) {
      debugPrint('Error received: ${state.message}');
    }
  }

  /// Builds the header section with the title.
  /// Displays the "App icon" title with proper styling.
  ///
  /// Returns a Text widget with the header title
  Widget _buildHeader() {
    return const Text(
      'App icon',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.primaryColor),
    );
  }

  /// Builds the icon selection grid with available app icons.
  /// Creates a responsive grid layout with icon preview items.
  ///
  /// Returns a GridView.builder widget with icon items
  Widget _buildIconGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 18,
        mainAxisSpacing: 22,
      ),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        return IconSettingGridItem(
          isSelected: index == _selectedIndex,
          iconImage: _icons[index].previewPath,
          onPressed: () {
            _handleIconSelection(index);
          },
        );
      },
    );
  }

  /// Handles icon selection from the grid.
  /// Dispatches the ChangeIcon event to the bloc with the selected icon.
  ///
  /// [index] - The index of the selected icon in the grid
  void _handleIconSelection(int index) {
    context.read<IconBloc>().add(ChangeIcon(_icons[index]));
  }
}
