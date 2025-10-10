import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/domain/entities/collections/search_entity.dart';
import 'package:sureline/common/presentation/widgets/favourite_list_item.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/selection/collection_selection_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/search/presentation/bloc/search_bloc.dart';
import 'package:sureline/features/preferenecs/search/presentation/bloc/search_event.dart';
import 'package:sureline/features/preferenecs/search/presentation/bloc/search_state.dart';
import 'package:sureline/features/preferenecs/search/presentation/widget/sureline_search_bar.dart';

/// Full-screen bottom sheet for quote search functionality.
///
/// This widget provides a comprehensive search interface for discovering
/// and managing quotes. It includes real-time search with debouncing,
/// favorite management, collection organization, and result filtering.
/// The interface is designed for premium user experience with smooth
/// animations and intuitive interactions.
///
/// Key Features:
/// - Real-time search with custom search bar
/// - Favorite quote management
/// - Collection organization
/// - Result filtering and pagination
/// - Premium UI with smooth animations
/// - Portal integration for overlay management
///
/// UX Flow:
/// 1. User opens search bottom sheet
/// 2. Search bar provides real-time filtering
/// 3. Results display with favorite and collection options
/// 4. User can interact with individual quotes
/// 5. Collection selection available for organization
///
/// State Management:
/// - Uses SearchBloc for state management
/// - Implements BlocListener for state updates
/// - Provides BlocBuilder for UI updates
/// - Handles search query changes with debouncing
///
/// Design Considerations:
/// - Premium bottom sheet styling
/// - Consistent spacing and typography
/// - Intuitive search bar design
/// - Smooth list scrolling
/// - Accessible touch targets
///
/// Usage:
/// ```dart
/// showModalBottomSheet(
///   context: context,
///   isScrollControlled: true,
///   builder: (context) => SearchBottomSheet(),
/// );
/// ```
class SearchBottomSheet extends StatefulWidget {
  /// Creates a new SearchBottomSheet instance.
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  /// Controller for search text input.
  final TextEditingController _searchController = TextEditingController();

  /// Current search results from the bloc.
  List<SearchEntity> _search = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Provide SearchBloc with initial search event
        BlocProvider(
          create: (_) => locator<SearchBloc>()..add(OnSearchTextChanged(_searchController.text, 1)),
        ),
      ],
      child: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          // Update search results when state changes
          if (state is SearchedQuotes) {
            _search = state.result;
          }
        },
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Portal(
              child: Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search title header
                      const Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Custom search bar with real-time input
                      SurelineSearchBar(
                        controller:
                            _searchController..addListener(() {
                              // Trigger search on text change with debouncing
                              context.read<SearchBloc>().add(
                                OnSearchTextChanged(_searchController.text, 1),
                              );
                            }),
                      ),
                      const SizedBox(height: 27),
                      // Search results list
                      Expanded(
                        child: ListView.builder(
                          itemCount: _search.length,
                          itemBuilder: (context, index) {
                            return FavouriteListItem(
                              searchEntity: _search[index],
                              isOverlayVisible: false,
                              onOverlayToggled: (value) {},
                              onDeletePressed: () {},
                              isFavourite: _search[index].isFavourite,
                              onFavouritePressed: () {
                                // Toggle favorite status
                                context.read<SearchBloc>().add(
                                  OnLikePressed(
                                    isLiked: !_search[index].isFavourite,
                                    entity: _search[index],
                                  ),
                                );
                              },
                              onAddToCollectionPressed: () {
                                // Show collection selection bottom sheet
                                showModalBottomSheet<void>(
                                  context: Navigator.of(context, rootNavigator: true).context,
                                  builder:
                                      (ctx) => CollectionSelectionBottomSheet(
                                        searchId: _search[index].id,
                                        onSearchUpdated: (_, collectionsOfSearch) {
                                          // Update search entity with new collections
                                          setState(() {
                                            _search[index] = _search[index].copyWith(
                                              collections: collectionsOfSearch,
                                            );
                                          });
                                        },
                                      ),
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                );
                              },
                              isSearch: true,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Load more quotes button (currently disabled)
                      const SurelineButton(
                        text: 'See older quotes',
                        onPressed: null,
                        disableVerticalPadding: true,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
