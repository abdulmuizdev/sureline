import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bottom_sheets/create_and_edit_theme_bottom_sheet.dart';
import 'package:sureline/features/home/presentation/pages/home_screen.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_bloc.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_event.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_state.dart';
import 'package:sureline/features/theme_selection/presentation/main/widgets/theme_mix_selector_item.dart';
import 'package:sureline/features/theme_selection/presentation/main/widgets/theme_selector_item/theme_selector_item.dart';
import 'package:sureline/features/theme_selection/presentation/main/widgets/theme_type_selector_item.dart';
import 'package:sureline/features/theme_selection/presentation/theme_mixes/bottom_sheet/theme_mixes_bottom_sheet.dart';
import 'package:uuid/uuid.dart';

class ThemeSelectionBottomSheet extends StatefulWidget {
  final String quote;

  const ThemeSelectionBottomSheet({super.key, required this.quote});

  @override
  State<ThemeSelectionBottomSheet> createState() =>
      _ThemeSelectionBottomSheetState();
}

class _ThemeSelectionBottomSheetState extends State<ThemeSelectionBottomSheet> {
  List<ThemeEntity> _themes = [];

  List<ThemeEntity> _mixes = [];

  final List<String> _categories = [
    'Create',
    'All',
    'Free',
    'New',
    'Seasonal',
    'Most popular',
    'Recent',
  ];
  int _categorySelectedIndex = 1;
  int _themeSelectedIndex = 0;

  String _heading = 'For you';

  bool _showHeading = true;
  bool _showThemeMixes = true;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  locator<ThemeSelectorBloc>()
                    ..add(GetThemes())
                    ..add(GetThemeMixes()),
        ),
      ],
      child: BlocListener<ThemeSelectorBloc, ThemeSelectorState>(
        listener: (context, state) {
          if (state is GotThemes) {
            _themes = state.result;
            _themeSelectedIndex = state.activeIndex;

            debugPrint('active index is this $_themeSelectedIndex');
          }
          if (state is GotThemeMixes) {
            _mixes = state.result;
          }
          if (state is ChangedTheme) {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
        child: BlocBuilder<ThemeSelectorBloc, ThemeSelectorState>(
          builder: (context, state) {
            return Container(
              decoration: Utils.bottomSheetDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 27),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 18),
                                child: Text(
                                  'Themes',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 26),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              itemCount: _categories.length,
                              itemBuilder: (context, index) {
                                return ThemeTypeSelectorItem(
                                  icon: (index == 0) ? Icons.add_rounded : null,
                                  label: _categories[index],
                                  isSelected: _categorySelectedIndex == index,
                                  onPressed: () {
                                    switch (index) {
                                      case 0:
                                        _showCreateThemeBottomSheet();
                                        break;
                                      case 1:
                                        setState(() {
                                          _categorySelectedIndex = index;
                                          _showHeading = true;
                                          _showThemeMixes = true;
                                          _heading = 'For you';
                                        });
                                        context.read<ThemeSelectorBloc>().add(
                                          GetThemes(),
                                        );
                                        break;
                                      case 2:
                                        setState(() {
                                          _categorySelectedIndex = index;
                                          _showHeading = false;
                                          _showThemeMixes = false;
                                        });
                                        context.read<ThemeSelectorBloc>().add(
                                          GetFreeThemes(),
                                        );
                                        break;
                                      case 3:
                                        setState(() {
                                          _categorySelectedIndex = index;
                                          _showHeading = true;
                                          _showThemeMixes = false;
                                          _heading = 'New';
                                        });
                                        context.read<ThemeSelectorBloc>().add(
                                          GetNewThemes(),
                                        );
                                        break;
                                      case 4:
                                        setState(() {
                                          _categorySelectedIndex = index;
                                          _showHeading = true;
                                          _showThemeMixes = true;
                                          _heading = 'Seasonal';
                                        });
                                        context.read<ThemeSelectorBloc>().add(
                                          GetSeasonalThemes(),
                                        );
                                        break;
                                      case 5:
                                        setState(() {
                                          _categorySelectedIndex = index;
                                          _showHeading = true;
                                          _showThemeMixes = true;
                                          _heading = 'Most popular';
                                        });
                                        context.read<ThemeSelectorBloc>().add(
                                          GetMostPopularThemes(),
                                        );
                                        break;
                                      case 6:
                                        setState(() {
                                          _categorySelectedIndex = index;
                                          _showHeading = false;
                                          _showThemeMixes = false;
                                        });
                                        context.read<ThemeSelectorBloc>().add(
                                          GetRecentThemes(),
                                        );
                                        break;
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 15),

                          if (_showThemeMixes) ...[
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 18,
                                right: 18,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Theme mixes',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        useSafeArea: true,
                                        context: context,
                                        builder:
                                            (context) => ThemeMixesBottomSheet(
                                              onCreatePressed: () {
                                                Navigator.of(context).pop();
                                                _showCreateThemeBottomSheet();
                                              },
                                            ),
                                      );
                                    },
                                    child: Text(
                                      'See all',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 22),
                            SizedBox(
                              height: 90,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _mixes.length,
                                itemBuilder: (context, index) {
                                  return ThemeMixSelectorItem(
                                    entity: _mixes[index],
                                    isSelected: false,
                                    isFirst: index == 0,
                                    onPressed: () {
                                      context.read<ThemeSelectorBloc>().add(
                                        ChangeTheme(_mixes[index]),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 22),
                          ],

                          if (_showHeading) ...[
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: Text(
                                    _heading,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],

                          SizedBox(height: 22),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 9),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              transitionBuilder: (
                                Widget child,
                                Animation<double> animation,
                              ) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.3),
                                      end: Offset.zero,
                                    ).animate(
                                      CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOutCubic,
                                      ),
                                    ),
                                    child: child,
                                  ),
                                );
                              },
                              child: GridView.builder(
                                key: ValueKey(
                                  _themes.length,
                                ), // Force rebuild when themes change
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 126 / 178,
                                      crossAxisSpacing: 1,
                                      mainAxisSpacing: 1,
                                    ),
                                itemCount: _themes.length,
                                itemBuilder: (context, index) {
                                  if (_themes[index].isActive) {
                                    debugPrint('here it is $index');
                                  }

                                  return AnimatedContainer(
                                    duration: Duration(
                                      milliseconds: 300 + (index * 50),
                                    ), // Staggered delay
                                    curve: Curves.easeOutBack,
                                    child: ThemeSelectorItem(
                                      entity: _themes[index],
                                      isSelected: _themeSelectedIndex == index,
                                      onPressed: () {
                                        context.read<ThemeSelectorBloc>().add(
                                          ChangeTheme(_themes[index]),
                                        );
                                        setState(() {
                                          _themeSelectedIndex = index;
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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

  void _showCreateThemeBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: false,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder:
          (context) => CreateAndEditThemeBottomSheet(entity: App.themeEntity),
    );
  }
}
