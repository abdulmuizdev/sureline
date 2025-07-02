import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/streak_container.dart';
import 'package:sureline/common/presentation/widgets/heading.dart';
import 'package:sureline/common/presentation/widgets/settings_list_item.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/app_icon_selection/presentation/bottom_sheet/app_icon_setting_bottom_sheet.dart';
import 'package:sureline/features/collections/presentation/pages/default/collections_bottom_sheet.dart';
import 'package:sureline/features/favourites/presentation/pages/favourites_bottom_sheet.dart';
import 'package:sureline/features/general_settings/default/presentation/pages/general_settings_bottom_sheet.dart';
import 'package:sureline/features/history/presentation/pages/history_bottom_sheet.dart';
import 'package:sureline/features/home_widget/presentation/bottom_sheet/home_widget_bottom_sheet.dart';
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/notifications_settings_bottom_sheet.dart';
import 'package:sureline/features/own_quotes/presentation/pages/own_quotes_bottom_sheet.dart';
import 'package:sureline/features/practice/presentation/bottom_sheets/practice_bottom_sheet.dart';
import 'package:sureline/features/practice/presentation/dialogs/practice_appreciation_dialog.dart';
import 'package:sureline/features/practice/presentation/dialogs/practice_dialog.dart';
import 'package:sureline/features/preferenecs/presentation/bloc/preferences_bloc.dart';
import 'package:sureline/features/preferenecs/presentation/bloc/preferences_event.dart';
import 'package:sureline/features/preferenecs/presentation/bloc/preferences_state.dart';
import 'package:sureline/features/search/presentation/pages/search_bottom_sheet.dart';

class PreferencesMainPage extends StatefulWidget {
  const PreferencesMainPage({super.key});

  @override
  State<PreferencesMainPage> createState() => _PreferencesMainPageState();
}

class _PreferencesMainPageState extends State<PreferencesMainPage> {
  List<StreakDisplayEntity> _streakData = [];
  bool _isShareEnabled = true;
  bool _showStreak = true;
  int _favouritesCount = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              locator<PreferencesBloc>()
                ..add(GetLastSevenDaysStreakData())
                ..add(GetStreakStatus())
                ..add(GetFavouritesCount()),
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
              if (!showAppreciationDialog) {
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
                        child: PracticeAppreciationDialog(),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sureline',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    // SizedBox(height: 10),
                    SizedBox(height: 16),
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
                      SizedBox(height: 22),
                    ],

                    Heading(text: 'SETTINGS'),

                    SizedBox(height: 15),

                    SettingsListItem(
                      title: 'General',
                      isFirst: true,
                      icon: CupertinoIcons.settings,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => GeneralSettingsBottomSheet(),
                          ),
                        );
                      },
                    ),
                    SettingsListItem(
                      title: 'App icon',
                      icon: Icons.menu_rounded,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => AppIconSettingBottomSheet(),
                          ),
                        );
                      },
                    ),
                    SettingsListItem(
                      title: 'Reminders',
                      icon: CupertinoIcons.alarm,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder:
                                (context) => NotificationsSettingsBottomSheet(),
                          ),
                        );
                      },
                    ),
                    SettingsListItem(
                      title: 'Home Screen widgets',
                      icon: CupertinoIcons.heart,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => HomeWidgetBottomSheet(),
                          ),
                        );
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
                    SizedBox(height: 22),
                    Heading(text: 'YOUR QUOTES'),
                    SizedBox(height: 15),
                    SettingsListItem(
                      title: 'Collections',
                      icon: CupertinoIcons.bookmark,
                      isFirst: true,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => CollectionsBottomSheet(),
                          ),
                        );
                      },
                    ),
                    SettingsListItem(
                      title: 'Your own quotes',
                      icon: CupertinoIcons.heart,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => OwnQuotesBottomSheet(),
                          ),
                        );
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
                              (context, animation, secondaryAnimation) =>
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: PracticeDialog(),
                                    ),
                                  ),
                          transitionBuilder: Utils.dialogTransitionBuilder,
                        );
                        if (!context.mounted || option == null) return;
                        context.read<PreferencesBloc>().add(
                          GetRandomQuotes(option),
                        );
                      },
                    ),
                    SettingsListItem(
                      title: 'Search',
                      icon: CupertinoIcons.search,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => SearchBottomSheet(),
                          ),
                        );
                      },
                    ),
                    SettingsListItem(
                      title: 'History',
                      icon: CupertinoIcons.hourglass_bottomhalf_fill,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => HistoryBottomSheet(),
                          ),
                        );
                      },
                    ),
                    SettingsListItem(
                      title: 'Favourites ($_favouritesCount)',
                      icon: CupertinoIcons.heart,
                      isLast: true,
                      onPressed: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => FavouritesBottomSheet(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    SizedBox(height: 22),
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
