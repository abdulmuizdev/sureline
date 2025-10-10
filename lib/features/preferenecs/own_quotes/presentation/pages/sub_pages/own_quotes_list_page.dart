import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';
import 'package:sureline/common/presentation/widgets/favourite_list_item.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/selection/collection_selection_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_state.dart';
import 'package:sureline/features/preferenecs/search/presentation/widget/sureline_search_bar.dart';

/// Page widget for displaying and managing user's own quotes.
///
/// This widget provides a comprehensive interface for users to view,
/// create, and manage their custom quotes. It includes features like:
/// - Displaying all custom quotes in a scrollable list
/// - Search functionality to filter own quotes
/// - Adding own quotes to collections
/// - Deleting own quotes with confirmation
/// - Favourite/unfavourite functionality
/// - Empty state with encouraging message when no quotes exist
/// - Navigation to create new quotes
///
/// The widget follows the Clean Architecture pattern by using BlocProvider
/// for state management and delegating business logic to the OwnQuotesBloc.
class OwnQuotesListPage extends StatefulWidget {
  final VoidCallback onNext;
  const OwnQuotesListPage({super.key, required this.onNext});

  @override
  State<OwnQuotesListPage> createState() => _OwnQuotesListPageState();
}

class _OwnQuotesListPageState extends State<OwnQuotesListPage> {
  /// List of own quote entities currently displayed
  List<OwnQuoteEntity> _ownQuotes = [];

  /// Index of the quote that currently has the delete overlay visible
  /// -1 indicates no overlay is visible
  int _deleteOverlayVisibleIndex = -1;

  @override
  void initState() {
    super.initState();
    // Trigger initial data loading after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OwnQuotesBloc>().add(GetOwnQuotes());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OwnQuotesBloc, OwnQuotesState>(
      listener: (context, state) {
        // Update local state when own quotes are loaded
        if (state is GotOwnQuotes) {
          _ownQuotes = [...(state.ownQuotes ?? [])];
          if (_ownQuotes.isNotEmpty) {
            print('collections of own quotes: ${_ownQuotes[0].collections.length}');
          }
        }
      },
      child: BlocBuilder<OwnQuotesBloc, OwnQuotesState>(
        builder: (context, state) {
          // Show empty state when no own quotes exist
          if (_ownQuotes.isEmpty) {
            return Container(
              color: AppColors.white,
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title
                  Text(
                    'Your own quotes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const Spacer(),
                  // Empty state with encouraging message
                  Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        SizedBox(
                          width: 250,
                          height: 250,
                          child: Image.asset('assets/images/writing.png'),
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
                  // Add quote button
                  SurelineButton(
                    text: 'Add quote',
                    onPressed: () async {
                      widget.onNext();
                      context.push('/own-quotes/create');
                    },
                  ),
                ],
              ),
            );
          } else {
            // Show own quotes list when data exists
            return Portal(
              child: GestureDetector(
                // Dismiss delete overlay when tapping outside
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
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with title
                        Text(
                          'Your own quotes',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Search bar for filtering own quotes
                        SurelineSearchBar(controller: SearchController()),
                        // SizedBox(height: 27),
                        // // Button to show all own quotes in the main feed
                        // SurelineButton(
                        //   isOutlined: true,
                        //   text: 'Show all in feed',
                        //   disableVerticalPadding: true,
                        //   onPressed: () {},
                        // ),
                        SizedBox(height: 27),
                        // Scrollable list of own quotes
                        Expanded(
                          child: ListView.builder(
                            itemCount: _ownQuotes.length,
                            itemBuilder: (context, index) {
                              return FavouriteListItem(
                                isOwnQuote: true,
                                isFavourite: _ownQuotes[index].isFavourite,
                                ownQuoteEntity: _ownQuotes[index],
                                // Handle favourite/unfavourite action
                                onFavouritePressed: () {
                                  context.read<OwnQuotesBloc>().add(
                                    OnLikePressed(
                                      _ownQuotes[index],
                                      !_ownQuotes[index].isFavourite,
                                    ),
                                  );
                                },

                                // Handle adding to collection
                                onAddToCollectionPressed: () {
                                  showModalBottomSheet(
                                    context: Navigator.of(context, rootNavigator: true).context,
                                    builder:
                                        (ctx) => CollectionSelectionBottomSheet(
                                          ownQuoteId: _ownQuotes[index].id,
                                          onOwnQuotesUpdated: (_, collectionsOfOwnQuote) {
                                            print(
                                              'collectionsOfOwnQuote: ${collectionsOfOwnQuote.length}',
                                            );
                                            setState(() {
                                              _ownQuotes[index] = _ownQuotes[index].copyWith(
                                                collections: collectionsOfOwnQuote,
                                              );
                                            });
                                          },
                                        ),
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                  );
                                },
                                // Handle delete action
                                onDeletePressed: () {
                                  setState(() {
                                    _deleteOverlayVisibleIndex = -1;
                                  });
                                  context.read<OwnQuotesBloc>().add(
                                    OnDeletePressed(_ownQuotes[index]),
                                  );
                                  context.read<OwnQuotesBloc>().add(GetOwnQuotes());
                                },
                                // Handle overlay visibility for delete confirmation
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
                                isOverlayVisible: _deleteOverlayVisibleIndex == index,
                              );
                            },
                          ),
                        ),
                        // Add quote button
                        SurelineButton(
                          text: 'Add quote',
                          onPressed: () async {
                            widget.onNext();
                            context.push('/own-quotes/create');
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
    );
  }
}
