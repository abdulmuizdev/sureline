import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/presentation/bottom_sheet/sub_pages/preferences_main_page.dart';

class PreferencesBottomSheet extends StatefulWidget {
  const PreferencesBottomSheet({super.key});

  @override
  State<PreferencesBottomSheet> createState() => _PreferencesBottomSheetState();
}

class _PreferencesBottomSheetState extends State<PreferencesBottomSheet> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String _appBarTitle = 'Done';

  @override
  void initState() {
    super.initState();
    _navigatorKey.currentState?.setState(() {});
  }

  void _handleBack() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      setState(() {
        _appBarTitle = 'Done';
      });
      _navigatorKey.currentState?.pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _handleBack();
                  },
                  child: Text(
                    _appBarTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 27),
              ],
            ),
          ),
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: (settings) {
                return CupertinoPageRoute(
                  builder: (context) => PreferencesMainPage(),
                  settings: settings,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
