import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/home/presentation/pages/home_screen.dart';

/// Screen that guides users through installing Sureline widgets on their Home Screen.
/// This screen provides step-by-step instructions and handles the app minimization
/// flow to allow users to access their Home Screen for widget installation.
///
/// The screen monitors app lifecycle changes to detect when users return from
/// the Home Screen, automatically navigating to the main app when they resume.
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

  /// Handles app lifecycle state changes to detect when users return from Home Screen.
  /// When the app is resumed, it automatically navigates to the main home screen
  /// with a fade transition, assuming the user has completed widget installation.
  ///
  /// [state] - The new app lifecycle state
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateToHomeScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Background(isStatic: true),
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
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: Image.asset('assets/images/home_screen.png'),
                ),
                Spacer(),
                SurelineButton(
                  disableVerticalPadding: true,
                  text: 'Install widget',
                  onPressed: () async {
                    _showInstallationDialog(context);
                  },
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    _navigateToHomeScreen();
                  },
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

  /// Shows a confirmation dialog before minimizing the app to open the Home Screen.
  /// The dialog explains that the app will close and the Home Screen will open,
  /// allowing users to proceed with widget installation.
  ///
  /// [context] - The build context for showing the dialog
  void _showInstallationDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text('\'Sureline\' would like to open your Home Screen'),
            content: Text('The app will close and your phone\'s Home Screen will open.'),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  'Open',
                  style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.normal),
                ),
                onPressed: () => _minimizeApp(),
              ),
            ],
          ),
    );
  }

  /// Minimizes the Flutter app to allow users to access their Home Screen
  /// for widget installation. This is the final step in the widget setup process.
  void _minimizeApp() {
    FlutterAppMinimizer.minimize();
  }

  /// Navigates to the main home screen with a fade transition.
  /// This method is called when users return from the Home Screen or choose
  /// to skip widget installation.
  void _navigateToHomeScreen() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
