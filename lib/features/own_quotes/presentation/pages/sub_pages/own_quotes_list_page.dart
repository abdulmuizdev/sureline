import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/presentation/widgets/favourite_list_item.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/collections/presentation/pages/selection/collection_selection_bottom_sheet.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_state.dart';
import 'package:sureline/features/own_quotes/presentation/pages/own_quotes_bottom_sheet.dart';
import 'package:sureline/features/own_quotes/presentation/pages/sub_pages/create_own_quote_page.dart';
import 'package:sureline/features/own_quotes/presentation/widgets/own_quote_list_item.dart';
import 'package:sureline/features/search/presentation/widget/sureline_search_bar.dart';

class OwnQuotesListPage extends StatefulWidget {
  final VoidCallback onNext;
  const OwnQuotesListPage({super.key, required this.onNext});

  @override
  State<OwnQuotesListPage> createState() => _OwnQuotesListPageState();
}

class _OwnQuotesListPageState extends State<OwnQuotesListPage> {
  List<OwnQuoteEntity> _ownQuotes = [];

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
            _ownQuotes = [...(state.ownQuotes ?? [])];
            if (_ownQuotes.isNotEmpty) {
              print(
                'collections of own quotes: ${_ownQuotes[0].collections.length}',
              );
            }
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
                      onPressed: () async {
                        widget.onNext();
                        final udpatedQuotes = await Navigator.of(
                          context,
                        ).push<List<OwnQuoteEntity>?>(
                          CupertinoPageRoute(
                            builder: (context) => const CreateOwnQuotePage(),
                          ),
                        );
                        setState(() {
                          _ownQuotes = udpatedQuotes ?? [];
                        });
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
                    decoration: BoxDecoration(color: AppColors.white),
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
                            isOutlined: true,
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
                                  isOwnQuote: true,
                                  isFavourite: _ownQuotes[index].isFavourite,
                                  ownQuoteEntity: _ownQuotes[index],
                                  onFavouritePressed: () {
                                    context.read<OwnQuotesBloc>().add(
                                      OnLikePressed(
                                        _ownQuotes[index],
                                        !_ownQuotes[index].isFavourite,
                                      ),
                                    );
                                  },
                                  onDeletePressed:
                                      () => context.read<OwnQuotesBloc>().add(
                                        OnDeletePressed(_ownQuotes[index]),
                                      ),
                                  onAddToCollectionPressed: () {
                                    showModalBottomSheet(
                                      context:
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).context,
                                      builder:
                                          (
                                            ctx,
                                          ) => CollectionSelectionBottomSheet(
                                            ownQuoteId: _ownQuotes[index].id,
                                            onOwnQuotesUpdated: (
                                              _,
                                              collectionsOfOwnQuote,
                                            ) {
                                              print(
                                                'collectionsOfOwnQuote: ${collectionsOfOwnQuote.length}',
                                              );
                                              setState(() {
                                                _ownQuotes[index] =
                                                    _ownQuotes[index].copyWith(
                                                      collections:
                                                          collectionsOfOwnQuote,
                                                    );
                                              });
                                            },
                                          ),
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                    );
                                  },
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
                          SurelineButton(
                            text: 'Add quote',
                            onPressed: () async {
                              widget.onNext();
                              final udpatedQuotes = await Navigator.of(
                                context,
                              ).push<List<OwnQuoteEntity>?>(
                                CupertinoPageRoute(
                                  builder:
                                      (context) => const CreateOwnQuotePage(),
                                ),
                              );
                              setState(() {
                                _ownQuotes = udpatedQuotes ?? [];
                              });
                            },
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
