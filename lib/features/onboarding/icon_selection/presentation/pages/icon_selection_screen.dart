import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/features/onboarding/icon_selection/domain/entity/icon_entity.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/bloc/icon_bloc.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/bloc/icon_event.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/bloc/icon_state.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/widgets/icon_grid_item.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/pages/theme_selection_screen.dart';

class IconSelectionScreen extends StatefulWidget {
  const IconSelectionScreen({super.key});

  @override
  State<IconSelectionScreen> createState() => _IconSelectionScreenState();
}

class _IconSelectionScreenState extends State<IconSelectionScreen> {
  List<IconEntity> _icons = [];
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<IconBloc>()..add(Initialize())),
      ],
      child: BlocListener<IconBloc, IconState>(
        listener: (context, state) {
          if (state is ChangedIcon) {
            debugPrint('changed icon');
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ThemeSelectionScreen()),
            );
          }
          if (state is Initialized) {
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
                  Background(),
                  SafeArea(
                    child: Column(
                      children: [
                        OnboardingHeading(
                          title: 'Which icon style do you like the most?',
                          subTitle:
                              'This will be the app\'s icon on your phone\'s Home Screen',
                          reduceMargins: true,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                },
                              );
                            },
                          ),
                        ),

                        SurelineButton(
                          text: 'Continue',
                          onPressed:
                              (_selectedIndex != null && _selectedIndex! >= 0)
                                  ? () {
                                    context.read<IconBloc>().add(
                                      ChangeIcon(_icons[_selectedIndex!]),
                                    );
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
}
