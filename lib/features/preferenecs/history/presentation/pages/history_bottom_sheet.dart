import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/common/presentation/widgets/favourite_list_item.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/selection/collection_selection_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/history/presentation/bloc/history_bloc.dart';
import 'package:sureline/features/preferenecs/history/presentation/bloc/history_event.dart';
import 'package:sureline/features/preferenecs/history/presentation/bloc/history_state.dart';

/// Bottom sheet widget for displaying user's browsing history.
///
/// This widget provides a comprehensive interface for users to view
/// and manage their browsing history. It includes features like:
/// - Displaying all previously viewed quotes in a scrollable list
/// - Favourite/unfavourite functionality for history items
/// - Adding history items to collections
/// - Empty state with encouraging message when no history exists
/// - Real-time state updates and gesture handling
///
/// The widget follows the Clean Architecture pattern by using BlocProvider
/// for state management and delegating business logic to the HistoryBloc.
class HistoryBottomSheet extends StatefulWidget {
  const HistoryBottomSheet({super.key});

  @override
  State<HistoryBottomSheet> createState() => _HistoryBottomSheetState();
}

class _HistoryBottomSheetState extends State<HistoryBottomSheet> {
  /// List of history entities currently displayed
  List<HistoryEntity> _quotes = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the HistoryBloc and trigger initial data loading
      create: (context) => locator<HistoryBloc>()..add(GetHistory()),
      child: BlocListener<HistoryBloc, HistoryState>(
        listener: (context, state) {
          // Update local state when history is loaded
          if (state is HistoryLoaded) {
            _quotes = [...state.history];
            print(_quotes.length);
          }
        },
        child: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            // Show empty state when no history exists
            if (_quotes.isEmpty) {
              return Container(
                padding: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
                decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with title
                    Text('History', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                    SizedBox(height: 27),
                    const Spacer(),
                    // Empty state with encouraging message
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          SizedBox(
                            width: 250,
                            height: 250,
                            child: Image.asset('assets/images/books.png'),
                          ),
                          const OnboardingHeading(
                            reduceMargins: true,
                            title: 'Your scrolled quotes will appear here',
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                  ],
                ),
              );
            } else {
              // Show history list when data exists
              return Portal(
                child: Container(
                  decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with title
                        Text(
                          'History',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 27),
                        // Scrollable list of history items
                        Expanded(
                          child: ListView.builder(
                            itemCount: _quotes.length,
                            itemBuilder: (context, index) {
                              return FavouriteListItem(
                                historyEntity: _quotes[index],
                                isFavourite: _quotes[index].isFavourite,
                                isHistory: true,
                                isOverlayVisible: false,
                                onOverlayToggled: (value) {},
                                onDeletePressed: () {},
                                // Handle favourite/unfavourite action
                                onFavouritePressed: () {
                                  context.read<HistoryBloc>().add(
                                    OnLikePressed(_quotes[index], !_quotes[index].isFavourite),
                                  );
                                },
                                // Handle adding to collection
                                onAddToCollectionPressed: () {
                                  showModalBottomSheet(
                                    context: Navigator.of(context, rootNavigator: true).context,
                                    builder:
                                        (ctx) => CollectionSelectionBottomSheet(
                                          historyId: _quotes[index].id,
                                          onHistoryUpdated: (_, collectionsOfHistory) {
                                            print(
                                              'collectionsOfHistory: ${collectionsOfHistory.length}',
                                            );
                                            setState(() {
                                              _quotes[index] = _quotes[index].copyWith(
                                                collections: collectionsOfHistory,
                                              );
                                            });
                                          },
                                        ),
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        // Commented out "See older quotes" button
                        // SizedBox(height: 20),
                        // SurelineButton(
                        //   text: 'See older quotes',
                        //   onPressed: () {},
                        //   disableVerticalPadding: true,
                        // ),
                      ],
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
