import 'package:app_minimizer/app_minimizer.dart';
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
import 'package:sureline/features/recommendation_algorithm/domain/entity/quote_entity.dart';
import 'package:sureline/features/search/domain/entity/search_entity.dart';
import 'package:sureline/features/search/presentation/bloc/search_bloc.dart';
import 'package:sureline/features/search/presentation/bloc/search_event.dart';
import 'package:sureline/features/search/presentation/bloc/search_state.dart';
import 'package:sureline/features/search/presentation/widget/search_list_item.dart';
import 'package:sureline/features/search/presentation/widget/sureline_search_bar.dart';

class SearchBottomSheet extends StatefulWidget {
  const SearchBottomSheet({super.key});

  @override
  State<SearchBottomSheet> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchEntity> _search = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) =>
                  locator<SearchBloc>()
                    ..add(OnSearchTextChanged(_searchController.text, 1)),
        ),
      ],
      child: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchedQuotes) {
            _search = state.result;
          }
        },
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Portal(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                  color: AppColors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_left_rounded,
                                  color: AppColors.primaryColor,
                                ),
                                Text(
                                  'Sureline',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'View all',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 27),
                      Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 10),
                      SurelineSearchBar(
                        controller:
                            _searchController..addListener(() {
                              context.read<SearchBloc>().add(
                                OnSearchTextChanged(_searchController.text, 1),
                              );
                            }),
                      ),
                      SizedBox(height: 27),
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
                                context.read<SearchBloc>().add(
                                  OnLikePressed(
                                    !_search[index].isFavourite,
                                    _search[index],
                                  ),
                                );
                              },
                              onAddToCollectionPressed: () {
                                showModalBottomSheet(
                                  context:
                                      Navigator.of(
                                        context,
                                        rootNavigator: true,
                                      ).context,
                                  builder:
                                      (ctx) => CollectionSelectionBottomSheet(
                                        searchId: _search[index].id,

                                        onSearchUpdated: (
                                          _,
                                          collectionsOfSearch,
                                        ) {
                                          print(
                                            'collectionsOfSearch: ${collectionsOfSearch.length}',
                                          );
                                          setState(() {
                                            _search[index] = _search[index]
                                                .copyWith(
                                                  collections:
                                                      collectionsOfSearch,
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
                      SizedBox(height: 12),
                      SurelineButton(
                        text: 'See older quotes',
                        onPressed: () {},
                        disableVerticalPadding: true,
                      ),
                      SizedBox(height: 12),
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
