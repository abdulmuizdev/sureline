import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';
import 'package:sureline/common/presentation/bloc/icon_bloc.dart';
import 'package:sureline/common/presentation/bloc/icon_event.dart';
import 'package:sureline/common/presentation/bloc/icon_state.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/widgets/icon_grid_item.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/pages/theme_selection_screen.dart';

/// Screen for selecting the app icon during the onboarding process.
/// This screen displays a grid of available app icons and allows users
/// to choose their preferred icon style for the app's Home Screen appearance.
///
/// The screen includes state management for icon selection and handles
/// the icon change process through the IconBloc.
class IconSelectionScreen extends StatefulWidget {
  const IconSelectionScreen({super.key});

  @override
  State<IconSelectionScreen> createState() => _IconSelectionScreenState();
}

class _IconSelectionScreenState extends State<IconSelectionScreen> {
  /// List of available app icons retrieved from the bloc.
  /// Contains all icon options that users can choose from.
  List<IconEntity> _icons = [];

  /// Index of the currently selected icon in the grid.
  /// Tracks which icon the user has selected for preview.
  int? _selectedIndex;

  /// Index of the currently active/installed icon.
  /// Represents the icon that is currently set as the app icon.
  int? _activeIconIndex;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<IconBloc>()..add(Initialize()))],
      child: BlocListener<IconBloc, IconState>(
        listener: (context, state) {
          if (state is ChangedIcon) {
            _navigateToNextScreen();
          }
          if (state is Initialized) {
            _activeIconIndex = state.selectedIndex;
            _selectedIndex = state.selectedIndex;
            _icons = state.icons;
          }
          if (state is IconError) {
            debugPrint('error received');
            debugPrint(state.message);
          }
        },
        child: BlocBuilder<IconBloc, IconState>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  Background(isStatic: true),
                  SafeArea(
                    child: Column(
                      children: [
                        OnboardingHeading(
                          title: 'Which icon style do you like the most?',
                          subTitle: 'This will be the app\'s icon on your phone\'s Home Screen',
                          reduceMargins: true,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _icons.length,
                            itemBuilder: (context, index) {
                              return IconGridItem(
                                isSelected: _selectedIndex == index,
                                iconImage: _icons[index].previewPath,
                                onPressed: () {
                                  _selectIcon(index);
                                },
                              );
                            },
                          ),
                        ),

                        SurelineButton(
                          text: 'Continue',
                          onPressed:
                              _canContinue()
                                  ? () {
                                    _handleContinuePressed(context);
                                  }
                                  : null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Selects an icon at the specified index and updates the UI state.
  /// This method handles the visual selection of icons in the grid.
  ///
  /// [index] - The index of the icon to select
  void _selectIcon(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// Checks if the continue button should be enabled.
  /// Returns true if a valid icon is selected.
  bool _canContinue() {
    return _selectedIndex != null && _selectedIndex! >= 0;
  }

  /// Handles the continue button press with icon change logic.
  /// If a different icon is selected, it triggers the icon change process.
  /// If the same icon is selected, it proceeds to the next screen.
  ///
  /// [context] - The build context for bloc access
  void _handleContinuePressed(BuildContext context) {
    if (_selectedIndex != _activeIconIndex) {
      context.read<IconBloc>().add(ChangeIcon(_icons[_selectedIndex!]));
    } else {
      _navigateToNextScreen();
    }
  }

  /// Navigates to the next onboarding step (theme selection screen).
  /// This method handles the transition to the theme selection step,
  /// maintaining the onboarding flow sequence.
  void _navigateToNextScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ThemeSelectionScreen()));
  }
}
