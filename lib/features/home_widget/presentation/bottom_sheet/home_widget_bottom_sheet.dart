import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';

/// Displays a bottom sheet that guides users through the process of adding
/// Sureline widgets to their iOS Home Screen. This component provides step-by-step
/// instructions and handles the app minimization flow when users choose to install
/// the widget.
///
/// The bottom sheet includes:
/// - Visual demonstration of the widget appearance
/// - Step-by-step installation instructions
/// - Interactive button to minimize app and open Home Screen
class HomeWidgetBottomSheet extends StatelessWidget {
  const HomeWidgetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18),
      decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Widgets',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Stack(
              children: [
                Image.asset('assets/images/home_widget.png', width: 313, height: 412),
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 33),
                      child: Text(
                        'Add a widget to your Home Screen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
              Expanded(
                child: Text(
                  "On your phone's Home Screen, touch and hold an empty area until the apps jiggle",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2. ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
              Expanded(
                child: Text(
                  'Tap the Edit button in the upper corner to add the widget',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Spacer(),
          SurelineButton(
            disableVerticalPadding: true,
            text: 'Install widget',
            onPressed: () {
              _showInstallationDialog(context);
            },
          ),
          const Spacer(),
        ],
      ),
    );
  }

  /// Displays a confirmation dialog before minimizing the app to open the Home Screen.
  /// The dialog explains that the app will close and the Home Screen will open,
  /// allowing users to proceed with widget installation.
  void _showInstallationDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: const Text("'Sureline' would like to open your Home Screen"),
            content: const Text("The app will close and your phone's Home Screen will open."),
            actions: [
              CupertinoDialogAction(
                child: const Text(
                  'Open',
                  style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.normal),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _minimizeApp();
                },
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
}
