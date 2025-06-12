import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/pages/icon_selection_screen.dart';
import 'package:sureline/features/onboarding/notification/presentation/widgets/notification_selector.dart';
import 'package:sureline/features/onboarding/notification/presentation/widgets/time_selector.dart';

class OnboardingNotificationScreen extends StatefulWidget {
  const OnboardingNotificationScreen({super.key});

  @override
  _OnboardingNotificationScreenState createState() =>
      _OnboardingNotificationScreenState();
}

class _OnboardingNotificationScreenState
    extends State<OnboardingNotificationScreen>
    with TickerProviderStateMixin {
  int _notificationCount = 10;
  double centerX = 0;
  double centerY = 0;
  bool _isFirstOverlayVisible = false;
  bool _isSecondOverlayVisible = false;
  String _firstTime = '9:00 AM';
  String _secondTime = '10:00 AM';

  late AnimationController _controller;
  late CurvedAnimation _animation;
  late Animation<Offset> _positionAnimation;

  late AnimationController _controller2;
  late Animation<Offset> _positionAnimation2;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
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
            if (_isFirstOverlayVisible || _isSecondOverlayVisible) {
              setState(() {
                _isFirstOverlayVisible = false;
                _isSecondOverlayVisible = false;
              });
            }
          },
          child: Stack(
            children: [
              Background(),
              SafeArea(
                child: Column(
                  children: [
                    OnboardingHeading(
                      title: 'Get quotes throughout the day',
                      subTitle:
                          'Reading quotes regularly will help you reach your goals',
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
                              SlideTransition(
                                position: _positionAnimation,
                                child: Image.asset(
                                  'assets/images/notification.png',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: FadeTransition(
                                  opacity: _animation,
                                  child: Center(
                                    child: AnimatedBuilder(
                                      animation: _controller2,
                                      builder: (context, child) {
                                        return Container(
                                          width: _widthAnimation.value,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: AppColors.pureWhite
                                                .withValues(alpha: 0.4),
                                            borderRadius: BorderRadius.circular(
                                              13,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    NotificationSelector(
                      onValueChanged: (value) {
                        setState(() {
                          _notificationCount = value;
                        });
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
                                  setState(() {
                                    _isFirstOverlayVisible = isVisible;
                                    if (_isSecondOverlayVisible) {
                                      _isSecondOverlayVisible = false;
                                    }
                                  });
                                },
                                onTimeChange: (newTime) {
                                  setState(() {
                                    _firstTime = newTime;
                                  });
                                },
                              ),
                            SizedBox(height: 1),
                            if (_notificationCount > 1)
                              TimeSelector(
                                isLast: true,
                                time: _secondTime,
                                isOverlayVisible: _isSecondOverlayVisible,
                                onOverlayToggled: (isVisible) {
                                  setState(() {
                                    _isSecondOverlayVisible = isVisible;
                                    if (_isFirstOverlayVisible) {
                                      _isFirstOverlayVisible = false;
                                    }
                                  });
                                },
                                onTimeChange: (newTime) {
                                  setState(() {
                                    _secondTime = newTime;
                                  });
                                },
                              ),
                            Spacer(),
                            SurelineButton(
                              text: 'Allow and Save',
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => IconSelectionScreen(),
                                  ),
                                );
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
}
