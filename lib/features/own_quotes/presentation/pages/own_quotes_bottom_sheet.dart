import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/own_quotes/presentation/pages/sub_pages/own_quotes_list_page.dart';
import 'package:sureline/common/presentation/widgets/bottom_sheet_app_bar.dart';

class OwnQuotesBottomSheet extends StatefulWidget {
  const OwnQuotesBottomSheet({super.key});

  @override
  State<OwnQuotesBottomSheet> createState() => _OwnQuotesBottomSheetState();
}

class _OwnQuotesBottomSheetState extends State<OwnQuotesBottomSheet> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String _appBarTitle = 'Sureline';

  @override
  void initState() {
    super.initState();
    _navigatorKey.currentState?.setState(() {});
  }

  void _handleBack() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      setState(() {
        _appBarTitle = 'Sureline';
      });
      _navigatorKey.currentState?.pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(18),
              child: BottomSheetAppBar(
                title: _appBarTitle,
                onBack: _handleBack,
              ),
            ),
            Expanded(
              child: Navigator(
                key: _navigatorKey,
                onGenerateRoute: (settings) {
                  return CupertinoPageRoute(
                    builder:
                        (context) => OwnQuotesListPage(
                          onNext: () {
                            setState(() {
                              _appBarTitle = 'Back';
                            });
                          },
                        ),
                    settings: settings,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
