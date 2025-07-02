import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_group_directory/flutter_app_group_directory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_color_picker_with_title/custom_picker/extensions.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:screenshot_callback/screenshot_callback.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preference_app_group/shared_preference_app_group.dart';
import 'package:sureline/common/domain/entities/streak_display_entity.dart';
import 'package:sureline/common/presentation/dialog/streak/page/streak_bottom_sheet.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/features/general_settings/streak/presentation/pages/streak_setting_bottom_sheet.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/presentation/bloc/home_bloc.dart';
import 'package:sureline/features/home/presentation/bloc/home_event.dart';
import 'package:sureline/features/home/presentation/bloc/home_state.dart';
import 'package:sureline/features/home/presentation/dialogs/like_detail_bottom_sheet.dart';
import 'package:sureline/features/home/presentation/dialogs/share_bottom_sheet.dart';
import 'package:sureline/features/home/presentation/snackbars/feed_setup_snack_bar.dart';
import 'package:sureline/features/home/presentation/widgets/home_list_item.dart';
import 'package:sureline/common/presentation/widgets/watermark.dart';
import 'package:sureline/features/preferenecs/presentation/bottom_sheet/preferences_bottom_sheet.dart';
import 'package:sureline/features/share/presentation/pages/share_controls_bottom_sheet.dart';
import 'package:sureline/features/home/presentation/widgets/home_button.dart';
import 'package:sureline/features/home/presentation/widgets/like_progress.dart';
import 'package:sureline/features/share/presentation/snackbars/theme_changed_snack_bar/theme_changed_snack_bar.dart';
import 'package:sureline/common/domain/entities/streak_entity.dart';
import 'package:sureline/features/theme_selection/presentation/main/bottom_sheet/theme_selection_bottom_sheet.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  final bool? isThemeChanged;

  const HomeScreen({super.key, this.isThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _controlsFadeAnimation;
  late AnimationController _controller;
  final PageController _pageController = PageController();
  final List<QuoteEntity> _quotes = [];
  int _page = 0;

  bool _showExtraWidgets = true;
  GlobalKey _exportKey = GlobalKey();

  bool _isSwipeCompleted = false;
  bool _isShareGuideShown = false;
  bool _isFeedSetupShown = false;
  bool _isLikeGuideShown = false;
  bool _showLikeProgress = false;
  bool _showWaterMark = true;
  int _likeCount = 0;
  int _currentIndex = 0;

  final ScreenshotCallback screenshotCallback = ScreenshotCallback();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _controlsFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      screenshotCallback.addListener(() {
        _showShareBottomSheet(_currentIndex);
      });
      await Future.delayed(Duration(seconds: 1));

      if ((widget.isThemeChanged ?? false) && context.mounted) {
        final entity = _quotes[_pageController.position.pixels.round()];
        Utils.showCustomSnackBar(
          context,
          ThemeChangedSnackBar(
            onRenderComplete: () {
              setState(() {
                _showExtraWidgets = true;
              });
            },
            onShareItemPressed: () {
              setState(() {
                _showExtraWidgets = false;
              });
            },
            quote: entity.quoteText,
            exportKey: _exportKey,
            quoteKey: entity.quoteKey,
            isLiveBackground: App.themeEntity.backgroundEntity.isLiveBackground,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    debugPrint('disposing home screen');
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  locator<HomeBloc>()
                    ..add(GetQuotes(_page))
                    ..add(OnboardingComplete())
                    ..add(IsSwipeComplete())
                    ..add(IsFeedSetupShown())
                    ..add(GetLikeCount())
                    ..add(IsShareGuideShown())
                    ..add(IsLikeGuideShown())
                    ..add(UpdateStreak()),
          // ..add(GetLastSevenDaysStreakData())
        ),
      ],
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is StreakIsBroken) {
            debugPrint('streak is broken');
          }
          if (state is GotLastSevenDaysStreakData) {
            showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              builder:
                  (context) => StreakBottomSheet(entities: state.streakData),
            );
          }
          if (state is ShowStreakBottomSheet) {
            showModalBottomSheet(
              useSafeArea: true,
              isScrollControlled: true,
              context: context,
              builder:
                  (context) => StreakBottomSheet(entities: state.streakData),
            );
          }
          if (state is GotQuotes) {
            _quotes.addAll(state.result);
          }
          if (state is GotSwipeCompleteState) {
            _isSwipeCompleted = state.isCompleted;
          }
          if (state is GotShareGuideState) {
            _isShareGuideShown = state.isShown;
          }
          if (state is GotFeedSetupState) {
            _isFeedSetupShown = state.isShown;
          }
          if (state is GotLikeGuideState) {
            _isLikeGuideShown = state.isShown;
          }
          if (state is GotLikeCount) {
            _likeCount = state.likeCount;
            if (_likeCount == 3 && !_isShareGuideShown) {
              if (!_isShareGuideShown) {
                Future.delayed(Duration(milliseconds: 500), () {
                  if (context.mounted) {
                    HapticFeedback.lightImpact();
                    _showLikeProgress = true;
                    _openShareDialog();
                  }
                });
              } else {
                _showLikeProgress = true;
              }

              context.read<HomeBloc>().add(OnShareGuideShown());
            }

            if (_likeCount >= Constants.minimumLikeGoal && !_isFeedSetupShown) {
              debugPrint('showing feed setup');
              Utils.showCustomSnackBar(context, FeedSetupSnackBar());
              context.read<HomeBloc>().add(OnFeedSetupShown());
            }
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return RepaintBoundary(
              key: _exportKey,
              child: Scaffold(
                body: Stack(
                  children: [
                    Positioned.fill(child: Background()),
                    Stack(
                      children: [
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: PageView(
                            controller: _pageController,
                            scrollDirection: Axis.vertical,
                            onPageChanged: (int pageIndex) {
                              // Update current index
                              setState(() {
                                _currentIndex = pageIndex;
                              });

                              if (_quotes.isNotEmpty) {
                                context.read<HomeBloc>().add(
                                  MarkQuoteAsShown(_quotes[pageIndex].id),
                                );
                              }
                              // Handle swipe completion
                              if (pageIndex >= 1 &&
                                  _controlsFadeAnimation.value == 0) {
                                context.read<HomeBloc>().add(OnSwipeComplete());
                                _controller.forward();
                              }

                              // Handle like guide at index 2
                              if (pageIndex == 2) {
                                debugPrint(
                                  'like guide is this $_isLikeGuideShown',
                                );
                                if (_likeCount < Constants.minimumLikeGoal) {
                                  if (!_isLikeGuideShown) {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder:
                                          (context) => LikeDetailBottomSheet(),
                                    );
                                    setState(() {
                                      _isLikeGuideShown = true;
                                    });
                                    context.read<HomeBloc>().add(
                                      OnLikeGuideShown(),
                                    );
                                  } else {
                                    setState(() {
                                      _showLikeProgress = true;
                                    });
                                  }
                                }
                              }

                              // Load more quotes when near the end
                              if (pageIndex >= _quotes.length - 3) {
                                _page++;
                                print('getting more quotes $_page');
                                context.read<HomeBloc>().add(GetQuotes(_page));
                              }
                            },
                            children: List.generate(
                              _quotes.length,
                              (index) => HomeListItem(
                                quoteKey: _quotes[index].quoteKey,
                                isWelcome:
                                    (_isSwipeCompleted) ? false : index == 0,
                                showSwipeUp:
                                    (_isSwipeCompleted) ? false : index >= 1,
                                showSwipeGuide:
                                    (_isSwipeCompleted) ? false : index == 1,
                                quote: _quotes[index].quoteText,
                                isLiked: _quotes[index].isLiked,
                                showExtras: _showExtraWidgets,
                                showWaterMark: _showWaterMark,
                                onTap: () {
                                  Future.delayed(
                                    Duration(milliseconds: 500),
                                    () {
                                      HapticFeedback.lightImpact();
                                      if (context.mounted) {
                                        _pageController.animateToPage(
                                          index + 1,
                                          duration: Duration(milliseconds: 250),
                                          curve: Curves.linear,
                                        );
                                      }
                                    },
                                  );
                                },
                                onLikePressed: (isLiked) {
                                  context.read<HomeBloc>().add(
                                    OnLikePressed(isLiked, _quotes[index]),
                                  );
                                  final current = _quotes[index];
                                  setState(() {
                                    _quotes[index] = (current).copyWith(
                                      isLiked: !current.isLiked,
                                    );
                                  });
                                },
                                onSharePressed: () {
                                  HapticFeedback.lightImpact();
                                  _showShareBottomSheet(index);
                                },
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 500),
                            opacity:
                                _showExtraWidgets
                                    ? (_isSwipeCompleted)
                                        ? 1
                                        : 0
                                    : 0,
                            child: FadeTransition(
                              opacity:
                                  (_isSwipeCompleted)
                                      ? Tween<double>(begin: 1, end: 1).animate(
                                        CurvedAnimation(
                                          parent: _controller,
                                          curve: Curves.linear,
                                        ),
                                      )
                                      : _controlsFadeAnimation,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 30,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          child: HomeButton(
                                            icon:
                                                Icons
                                                    .imagesearch_roller_outlined,
                                          ),
                                          onTap: () {
                                            HapticFeedback.lightImpact();
                                            showModalBottomSheet(
                                              useSafeArea: true,
                                              isScrollControlled: true,
                                              context: context,
                                              builder:
                                                  (
                                                    context,
                                                  ) => ThemeSelectionBottomSheet(
                                                    quote:
                                                        _quotes[(_pageController
                                                                        .page ??
                                                                    1)
                                                                .round()]
                                                            .quoteText,
                                                  ),
                                            );
                                          },
                                        ),
                                        GestureDetector(
                                          child: HomeButton(
                                            icon: Icons.person_3_outlined,
                                          ),
                                          onTap: () {
                                            HapticFeedback.lightImpact();
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              useSafeArea: true,
                                              context: context,
                                              builder:
                                                  (context) =>
                                                      PreferencesBottomSheet(),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity:
                          (_showExtraWidgets)
                              ? (_showLikeProgress)
                                  ? ((_likeCount < Constants.minimumLikeGoal)
                                      ? 1
                                      : 0)
                                  : 0
                              : 0,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 66),
                          child: LikeProgress(
                            likeCount: _likeCount,
                            likeGoal: Constants.minimumLikeGoal,
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                useSafeArea: true,
                                context: context,
                                builder: (context) => LikeDetailBottomSheet(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openShareDialog() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder:
          (context) => ShareBottomSheet(
            onSharePressed: () {
              Navigator.of(context).pop();
              //tag
              if (_pageController.page != null) {
                _showShareBottomSheet(_pageController.page!.round());
              }
            },
          ),
    );
  }

  void _showShareBottomSheet(int index) async {
    setState(() {
      _showExtraWidgets = false;
    });
    await Future.delayed(Duration(milliseconds: 500));
    if (context.mounted) {
      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        // removes the default white
        // barrierColor: Colors.black, // or Colors.transparent for no dim
        isScrollControlled: true,
        // optional: makes it full height if needed
        useSafeArea: true,
        builder:
            (context) => ShareControlsBottomSheet(
              quoteId: _quotes[index].id,
              isWaterMarkShowing: _showWaterMark,
              onHideWaterMarkPressed: _hideWaterMark,
              quoteKey: _quotes[index].quoteKey,
              exportKey: _exportKey,
              quote: _quotes[index].quoteText,
              isLiveBackground:
                  App.themeEntity.backgroundEntity.isLiveBackground,
              onPop: () {
                setState(() {
                  _showExtraWidgets = true;
                });
              },
            ),
      );
    }
    setState(() {
      _showExtraWidgets = true;
    });
  }

  void _hideWaterMark() {
    setState(() {
      _showWaterMark = !_showWaterMark;
    });
  }
}
