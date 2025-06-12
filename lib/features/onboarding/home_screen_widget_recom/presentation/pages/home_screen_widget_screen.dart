import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/home/presentation/pages/home_screen.dart';

class HomeScreenWidgetScreen extends StatefulWidget {
  const HomeScreenWidgetScreen({super.key});

  @override
  State<HomeScreenWidgetScreen> createState() => _HomeScreenWidgetScreenState();
}

class _HomeScreenWidgetScreenState extends State<HomeScreenWidgetScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          PageRouteBuilder(
              pageBuilder:
                  (context, animation, secondaryAnimation) =>
                  HomeScreen(),
              transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                  ) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              transitionDuration: Duration(milliseconds: 300)
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          SafeArea(
            child: Column(
              children: [
                OnboardingHeading(
                  title: 'Add a widget to your Home Screen',
                  subTitle:
                      'On your phone\'s Home Screen, touch and hold an empty area, then tap Edit',
                  reduceMargins: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 25,
                  ),
                  child: Image.asset('assets/images/home_screen.png'),
                ),
                Spacer(),
                SurelineButton(
                  disableVerticalPadding: true,
                  text: 'Install widget',
                  onPressed: () async {
                    showCupertinoDialog(
                      context: context,
                      builder:
                          (_) => CupertinoAlertDialog(
                            title: Text(
                              '\'Sureline\' would like to open your Home Screen',
                            ),
                            content: Text(
                              'The app will close and your phone\'s Home Screen will open.',
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: Text(
                                  'Open',
                                  style: TextStyle(
                                    color: Color(0xFF007AFF),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                onPressed: () => FlutterAppMinimizer.minimize(),
                              ),
                            ],
                          ),
                    );
                  },
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Remind me later',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
