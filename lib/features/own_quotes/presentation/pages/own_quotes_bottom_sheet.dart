import 'package:app_minimizer/app_minimizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:sureline/features/favourites/presentation/widget/favourite_list_item.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_state.dart';
import 'package:sureline/features/search/presentation/widget/sureline_search_bar.dart';

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
                    builder: (context) => const FirstPage(),
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

class BottomSheetAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const BottomSheetAppBar({
    super.key,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack,
      child: Row(
        children: [
          Icon(
            Icons.keyboard_arrow_left_rounded,
            color: AppColors.primaryColor,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<QuoteEntity> _ownQuotes = [];

  int _deleteOverlayVisibleIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<OwnQuotesBloc>()..add(GetOwnQuotes()),
        ),
      ],
      child: BlocListener<OwnQuotesBloc, OwnQuotesState>(
        listener: (context, state) {
          if (state is GotOwnQuotes) {
            _ownQuotes = state.ownQuotes ?? [];
          }
        },
        child: BlocBuilder<OwnQuotesBloc, OwnQuotesState>(
          builder: (context, state) {
            if (_ownQuotes.isEmpty) {
              return Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your own quotes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 250,
                            height: 250,
                            child: Placeholder(),
                          ),
                          const OnboardingHeading(
                            reduceMargins: true,
                            title: 'You haven\'t added any quotes yet',
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                    SurelineButton(
                      text: 'Add quote',
                      onPressed: () {
                        final state =
                            context
                                .findAncestorStateOfType<
                                  _OwnQuotesBottomSheetState
                                >();
                        state?.setState(() {
                          state._appBarTitle = 'Back';
                        });
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const SecondPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Portal(
                child: GestureDetector(
                  onTap: () {
                    if (_deleteOverlayVisibleIndex >= 0) {
                      setState(() {
                        _deleteOverlayVisibleIndex = -1;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                      ),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 18,
                        left: 18,
                        right: 18,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 27),
                          Text(
                            'Your own quotes',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          SurelineSearchBar(controller: SearchController()),
                          SizedBox(height: 27),
                          SurelineButton(
                            text: 'Show all in feed',
                            onPressed: () {},
                            disableVerticalPadding: true,
                          ),
                          SizedBox(height: 27),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _ownQuotes.length,
                              itemBuilder: (context, index) {
                                return FavouriteListItem(
                                  entity: _ownQuotes[index],
                                  onDeletePressed: () {},
                                  // () => context.read<OwnQuotesBloc>().add(
                                  //   OnDeletePressed(_ownQuotes[index]),
                                  // )
                                  onOverlayToggled: (value) {
                                    if (value) {
                                      setState(() {
                                        _deleteOverlayVisibleIndex = index;
                                      });
                                    } else {
                                      setState(() {
                                        _deleteOverlayVisibleIndex = -1;
                                      });
                                    }
                                  },
                                  isOverlayVisible:
                                      _deleteOverlayVisibleIndex == index,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _quoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add new',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Add your own quote. It will only be visible to you',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 20),
          SurelineTextField(
            controller: _quoteController,
            showCharLimit: false,
            hint: 'Type your quote',
            disableCenterAlignment: true,
            isNameInput: true,
          ),
          Spacer(),
          SurelineButton(text: 'Save', onPressed: () {}),
        ],
      ),
    );
  }
}
