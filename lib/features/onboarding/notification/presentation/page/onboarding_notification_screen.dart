import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/domain/use_cases/schedule_up_to_sixty_notifications_use_case.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/sp.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/initialize_notifications_presets_use_case.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/pages/icon_selection_screen.dart';
import 'package:sureline/features/onboarding/notification/presentation/widgets/notification_selector.dart';
import 'package:sureline/features/onboarding/notification/presentation/widgets/time_selector.dart';

/// Screen for setting up notifications during the onboarding process.
/// This screen allows users to configure notification frequency and timing,
/// with animated visual demonstrations and interactive time selection.
///
/// The screen includes complex animations, notification limit handling,
/// and integration with the notification system for quote delivery.
class OnboardingNotificationScreen extends StatefulWidget {
  const OnboardingNotificationScreen({super.key});

  @override
  _OnboardingNotificationScreenState createState() => _OnboardingNotificationScreenState();
}

class _OnboardingNotificationScreenState extends State<OnboardingNotificationScreen>
    with TickerProviderStateMixin {
  /// Number of notifications to schedule per day.
  /// Controlled by the notification selector widget.
  int _notificationCount = 10;

  /// Center coordinates for animation positioning.
  double centerX = 0;
  double centerY = 0;

  /// Whether the first time selector overlay is visible.
  /// Controls the visibility of the first time picker.
  bool _isFirstOverlayVisible = false;

  /// Whether the second time selector overlay is visible.
  /// Controls the visibility of the second time picker.
  bool _isSecondOverlayVisible = false;

  /// The first notification time in string format.
  /// Defaults to '9:00 AM'.
  String _firstTime = '9:00 AM';

  /// The second notification time in string format.
  /// Defaults to '10:00 AM'.
  String _secondTime = '10:00 AM';

  /// Animation controller for the main notification animation.
  late AnimationController _controller;

  /// Curved animation for smooth transitions.
  late CurvedAnimation _animation;

  /// Position animation for the notification image.
  late Animation<Offset> _positionAnimation;

  /// Second animation controller for width animations.
  late AnimationController _controller2;

  /// Second position animation for additional effects.
  late Animation<Offset> _positionAnimation2;

  /// Width animation for the notification container.
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _controller2 = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _positionAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -(10 / 80)),
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.linear));

    _widthAnimation = Tween<double>(
      begin: 50,
      end: 302,
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.linear));

    _positionAnimation2 = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, (10 / 80)),
    ).animate(CurvedAnimation(parent: _controller2, curve: Curves.linear));

    _controller.addListener(() async {
      if (_controller.isCompleted) {
        await Future.delayed(Duration(milliseconds: 200), () {
          _controller2.forward();
        });
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            _hideOverlays();
          },
          child: Stack(
            children: [
              Background(isStatic: true),
              SafeArea(
                child: Column(
                  children: [
                    OnboardingHeading(
                      title: 'Get quotes throughout the day',
                      subTitle: 'Reading quotes regularly will help you reach your goals',
                      reduceMargins: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: FadeTransition(
                        opacity: _animation,
                        child: ScaleTransition(
                          scale: _animation,
                          child: Stack(
                            children: [
                              FadeTransition(
                                opacity: _animation,
                                child: Center(
                                  child: AnimatedBuilder(
                                    animation: _controller2,
                                    builder: (context, child) {
                                      return Container(
                                        width: _widthAnimation.value,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: AppColors.pureWhite.withValues(alpha: 0.4),
                                          borderRadius: BorderRadius.circular(13),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SlideTransition(
                                position: _positionAnimation,
                                child: Image.asset('assets/images/notification.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    NotificationSelector(
                      onValueChanged: (value) async {
                        _handleNotificationCountChange(value);
                      },
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_notificationCount > 0)
                              TimeSelector(
                                time: _firstTime,
                                isOverlayVisible: _isFirstOverlayVisible,
                                onOverlayToggled: (isVisible) {
                                  _handleFirstTimeOverlayToggle(isVisible);
                                },
                                onTimeChange: (newTime) {
                                  _handleFirstTimeChange(newTime);
                                },
                              ),
                            SizedBox(height: 1),
                            if (_notificationCount > 1)
                              TimeSelector(
                                isLast: true,
                                time: _secondTime,
                                isOverlayVisible: _isSecondOverlayVisible,
                                onOverlayToggled: (isVisible) {
                                  _handleSecondTimeOverlayToggle(isVisible);
                                },
                                onTimeChange: (newTime) {
                                  _handleSecondTimeChange(newTime);
                                },
                              ),
                            Spacer(),
                            SurelineButton(
                              text: 'Allow and Save',
                              onPressed: () async {
                                await _handleSaveAndContinue();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Hides all time selector overlays when tapping outside.
  /// This method ensures only one time picker is visible at a time.
  void _hideOverlays() {
    if (_isFirstOverlayVisible || _isSecondOverlayVisible) {
      setState(() {
        _isFirstOverlayVisible = false;
        _isSecondOverlayVisible = false;
      });
    }
  }

  /// Handles changes to the notification count from the selector.
  /// Shows a dialog when the limit is reached and manages the dialog state.
  ///
  /// [value] - The new notification count selected by the user
  void _handleNotificationCountChange(int value) async {
    setState(() {
      _notificationCount = value;
    });

    if (value == Constants.headsUpNotificationLimit) {
      final prefs = await SharedPreferences.getInstance();
      final hasShownDialog = prefs.getBool(SP.hasShownNotificationLimitDialog) ?? false;

      if (hasShownDialog) {
        return;
      }

      if (mounted && context.mounted) {
        _showNotificationLimitDialog();
        await prefs.setBool(SP.hasShownNotificationLimitDialog, true);
      }
    }
  }

  /// Shows a dialog explaining the notification limit.
  /// Informs users about the 60 notification limit and what to do if notifications stop.
  void _showNotificationLimitDialog() {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text('Heads up!'),
            content: Text(
              'We can only schedule up to 60 notifications at a time. If you stop getting them, please launch the app and they\'ll be reset.',
            ),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Done',
                  style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );
  }

  /// Handles toggle of the first time selector overlay.
  /// Ensures only one overlay is visible at a time.
  ///
  /// [isVisible] - Whether the overlay should be visible
  void _handleFirstTimeOverlayToggle(bool isVisible) {
    setState(() {
      _isFirstOverlayVisible = isVisible;
      if (_isSecondOverlayVisible) {
        _isSecondOverlayVisible = false;
      }
    });
  }

  /// Handles toggle of the second time selector overlay.
  /// Ensures only one overlay is visible at a time.
  ///
  /// [isVisible] - Whether the overlay should be visible
  void _handleSecondTimeOverlayToggle(bool isVisible) {
    setState(() {
      _isSecondOverlayVisible = isVisible;
      if (_isFirstOverlayVisible) {
        _isFirstOverlayVisible = false;
      }
    });
  }

  /// Updates the first notification time.
  ///
  /// [newTime] - The new time string to set
  void _handleFirstTimeChange(String newTime) {
    setState(() {
      _firstTime = newTime;
    });
  }

  /// Updates the second notification time.
  ///
  /// [newTime] - The new time string to set
  void _handleSecondTimeChange(String newTime) {
    setState(() {
      _secondTime = newTime;
    });
  }

  /// Handles the save and continue process.
  /// Initializes notification presets, schedules notifications,
  /// and navigates to the next onboarding step.
  Future<void> _handleSaveAndContinue() async {
    await locator<InitializeNotificationsPresetsUseCase>().execute();
    await locator<ScheduleUpToSixtyNotificationsUseCase>().execute();

    await Future.delayed(Duration(seconds: 1));
    await HapticFeedback.lightImpact();

    if (mounted && context.mounted) {
      _navigateToIconSelection();
    }
  }

  /// Navigates to the icon selection screen.
  /// This method handles the transition to the next onboarding step.
  void _navigateToIconSelection() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => IconSelectionScreen()));
  }
}
