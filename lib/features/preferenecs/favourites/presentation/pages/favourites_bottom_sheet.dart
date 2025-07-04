import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/selection/collection_selection_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:sureline/features/preferenecs/favourites/presentation/bloc/favourites_event.dart';
import 'package:sureline/features/preferenecs/favourites/presentation/bloc/favourites_state.dart';
import 'package:sureline/common/presentation/widgets/favourite_list_item.dart';
import 'package:sureline/features/preferenecs/search/presentation/widget/sureline_search_bar.dart';

class FavouritesBottomSheet extends StatefulWidget {
  const FavouritesBottomSheet({super.key});

  @override
  State<FavouritesBottomSheet> createState() => _FavouritesBottomSheetState();
}

class _FavouritesBottomSheetState extends State<FavouritesBottomSheet> {
  List<FavouriteEntity> _quotes = [];
  int _deleteOverlayVisibleIndex = -1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => locator<FavouritesBloc>()..add(GetFavouriteQuotes()),
        ),
      ],
      child: BlocListener<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state is GotFavouriteQuotes) {
            _quotes = [...(state.quotes ?? [])];
            _deleteOverlayVisibleIndex = -1;
          }
        },
        child: BlocBuilder<FavouritesBloc, FavouritesState>(
          builder: (context, state) {
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
                  color: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 18,
                      left: 18,
                      right: 18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Favourites',
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
                            itemCount: _quotes.length,
                            itemBuilder: (context, index) {
                              return FavouriteListItem(
                                favouriteEntity: _quotes[index],
                                ownQuoteEntity: null,
                                onAddToCollectionPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder:
                                        (ctx) => CollectionSelectionBottomSheet(
                                          favouriteId: _quotes[index].id,
                                          ownQuoteId: _quotes[index].ownQuoteId,
                                          quoteId: _quotes[index].quoteId,
                                          onFavouritesUpdated: (
                                            _,
                                            collectionsOfFavourite,
                                          ) {
                                            print(
                                              'collectionsOfFavourite: ${collectionsOfFavourite.length}',
                                            );
                                            setState(() {
                                              _quotes[index] = _quotes[index]
                                                  .copyWith(
                                                    collections:
                                                        collectionsOfFavourite,
                                                  );
                                            });
                                          },
                                        ),
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                  );
                                },
                                onDeletePressed:
                                    () => context.read<FavouritesBloc>().add(
                                      OnDeletePressed(_quotes[index]),
                                    ),
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
          },
        ),
      ),
    );
  }
}
