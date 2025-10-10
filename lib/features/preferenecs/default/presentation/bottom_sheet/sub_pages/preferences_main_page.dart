/// Main page for preferences interface.
///
/// Displays the primary preferences interface with streak data, settings
/// navigation, and practice functionality. This widget serves as the
/// central hub for accessing all app preferences and features.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/streak_container.dart';
import 'package:sureline/common/presentation/widgets/heading.dart';
import 'package:sureline/common/presentation/widgets/settings_list_item.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/default/presentation/bloc/preferences_bloc.dart';
import 'package:sureline/features/preferenecs/default/presentation/bloc/preferences_event.dart';
import 'package:sureline/features/preferenecs/default/presentation/bloc/preferences_state.dart';
import 'package:sureline/features/preferenecs/practice/presentation/bottom_sheets/practice_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/practice/presentation/dialogs/practice_appreciation_dialog.dart';
import 'package:sureline/features/preferenecs/practice/presentation/dialogs/practice_dialog.dart';

/// Main preferences page widget.
///
/// This widget displays the primary preferences interface including:
/// - Streak data visualization and sharing
/// - Settings navigation to various app sections
/// - Practice session functionality
/// - Favourites count display
///
/// Key features:
/// - Bloc integration for state management
/// - Streak container with sharing functionality
/// - Settings list with navigation
/// - Practice dialog integration
/// - Responsive design with proper spacing
class PreferencesMainPage extends StatefulWidget {
  /// Creates a new preferences main page.
  const PreferencesMainPage({super.key});

  @override
  State<PreferencesMainPage> createState() => _PreferencesMainPageState();
}

class _PreferencesMainPageState extends State<PreferencesMainPage> {
  /// Current streak data for display.
  List<StreakDisplayEntity> _streakData = [];

  /// Whether share functionality is enabled.
  bool _isShareEnabled = true;

  /// Whether to show streak features.
  bool _showStreak = true;

  /// Current favourites count.
  int _favouritesCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              locator<PreferencesBloc>()
                ..add(const GetLastSevenDaysStreakData())
                ..add(const GetStreakStatus())
                ..add(const GetFavouritesCount()),
      child: BlocListener<PreferencesBloc, PreferencesState>(
        listener: (context, state) {
          if (state is GotRandomQuotes) {
            showModalBottomSheet(
              isScrollControlled: true,
              useSafeArea: true,
              context: context,
              builder:
                  (context) => PracticeBottomSheet(
                    quotes: state.result,
                    perQuoteDuration: state.perQuoteDuration,
                  ),
            ).then((showAppreciationDialog) {
              if (showAppreciationDialog != true) {
                return;
              }
              if (!context.mounted) return;
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: '',
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder:
                    (context, animation, secondaryAnimation) => Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const PracticeAppreciationDialog(),
                      ),
                    ),
                transitionBuilder: Utils.dialogTransitionBuilder,
              );
            });
          }
          if (state is GotStreakStatus) {
            _showStreak = state.isEnabled;
          }
          if (state is GotLastSevenDaysStreakData) {
            _streakData = state.result;
          }
          if (state is RenderingStreakPost) {
            _isShareEnabled = false;
          }
          if (state is RenderedStreakPost) {
            _isShareEnabled = true;
          }
          if (state is GotFavouritesCount) {
            _favouritesCount = state.count;
          }
        },
        child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) {
            return Container(
              color: AppColors.white,
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sureline',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    // SizedBox(height: 10),
                    const SizedBox(height: 16),
                    if (_streakData.isNotEmpty && _showStreak) ...[
                      StreakContainer(
                        hideText: true,
                        increaseOpacity: true,
                        entities: _streakData,
                        showShare: true,
                        isShareEnabled: _isShareEnabled,
                        onSharePressed: () {
                          debugPrint('share is pressed');
                          context.read<PreferencesBloc>().add(
                            OnShareStreakPressed(
                              screenWidth: MediaQuery.of(context).size.width,
                              screenHeight: MediaQuery.of(context).size.height,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 22),
                    ],
                    const Heading(text: 'SETTINGS'),
                    const SizedBox(height: 15),
                    SettingsListItem(
                      title: 'General',
                      isFirst: true,
                      icon: CupertinoIcons.settings,
                      onPressed: () {
                        context.push('/general-settings');
                      },
                    ),
                    SettingsListItem(
                      title: 'App icon',
                      icon: Icons.menu_rounded,
                      onPressed: () {
                        context.push('/app-icon');
                      },
                    ),
                    SettingsListItem(
                      title: 'Reminders',
                      icon: CupertinoIcons.alarm,
                      onPressed: () {
                        context.push('/notifications');
                      },
                    ),
                    SettingsListItem(
                      title: 'Home Screen widgets',
                      icon: CupertinoIcons.heart,
                      isLast: true,
                      onPressed: () {
                        context.push('/home-widget');
                      },
                    ),
                    // SettingsListItem(
                    //   title: 'Watch',
                    //   icon: Icons.watch_rounded,
                    //   isLast: true,
                    //   onPressed: () {
                    //     showModalBottomSheet(
                    //       isScrollControlled: true,
                    //       useSafeArea: true,
                    //       context: context,
                    //       builder: (context) => WatchBottomSheet(),
                    //     );
                    //   },
                    // ),
                    const SizedBox(height: 22),
                    const Heading(text: 'YOUR QUOTES'),
                    const SizedBox(height: 15),
                    SettingsListItem(
                      title: 'Collections',
                      icon: CupertinoIcons.bookmark,
                      isFirst: true,
                      onPressed: () {
                        context.push('/collections');
                      },
                    ),
                    SettingsListItem(
                      title: 'Your own quotes',
                      icon: CupertinoIcons.heart,
                      onPressed: () {
                        context.push('/own-quotes');
                      },
                    ),
                    SettingsListItem(
                      title: 'Practice',
                      icon: CupertinoIcons.play,
                      onPressed: () async {
                        final int? option = await showGeneralDialog<int>(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: '',
                          transitionDuration: const Duration(milliseconds: 500),
                          pageBuilder:
                              (context, animation, secondaryAnimation) => Center(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: const PracticeDialog(),
                                ),
                              ),
                          transitionBuilder: Utils.dialogTransitionBuilder,
                        );
                        if (option != null && context.mounted) {
                          context.read<PreferencesBloc>().add(GetRandomQuotes(option));
                        }
                      },
                    ),
                    SettingsListItem(
                      title: 'Search',
                      icon: CupertinoIcons.search,
                      onPressed: () {
                        context.push('/search');
                      },
                    ),
                    SettingsListItem(
                      title: 'History',
                      icon: CupertinoIcons.clock,
                      onPressed: () {
                        context.push('/history');
                      },
                    ),
                    SettingsListItem(
                      title: 'Favourites',
                      icon: CupertinoIcons.heart_fill,
                      isLast: true,
                      onPressed: () {
                        context.push('/favourites');
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
