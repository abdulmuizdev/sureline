import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/presentation/widgets/favourite_list_item.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/selection/collection_selection_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';
import 'package:sureline/features/preferenecs/search/presentation/widget/sureline_search_bar.dart';

class CollectionDetailPage extends StatefulWidget {
  final int collectionId;
  final String name;
  final VoidCallback onFavouritesUpdated;
  const CollectionDetailPage({
    super.key,
    required this.collectionId,
    required this.name,
    required this.onFavouritesUpdated,
  });

  @override
  State<CollectionDetailPage> createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  List<FavouriteEntity> favourites = [];
  List<OwnQuoteEntity> ownQuotes = [];
  List<HistoryEntity> histories = [];
  List<SearchEntity> searchQuotes = [];
  int _deleteOverlayVisibleIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && context.mounted) {
        context.read<CollectionsBloc>().add(
          GetFavouritesOfCollection(widget.collectionId),
        );
        context.read<CollectionsBloc>().add(
          GetOwnQuotesOfCollection(widget.collectionId),
        );
        context.read<CollectionsBloc>().add(
          GetHistoryOfCollection(widget.collectionId),
        );
        context.read<CollectionsBloc>().add(
          GetSearchOfCollection(widget.collectionId),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionsBloc, CollectionsState>(
      listener: (context, state) {
        if (state is GotFavouritesOfCollection) {
          favourites = state.favourites ?? [];
        }
        if (state is GotOwnQuotesOfCollection) {
          print('ownQuotes: ${state.ownQuotes?.length}');

          ownQuotes = state.ownQuotes ?? [];
        }
        if (state is GotHistoryOfCollection) {
          print('history: ${state.history?.length}');

          histories = state.history ?? [];
        }
        if (state is GotSearchOfCollection) {
          searchQuotes = state.search ?? [];
        }
      },
      child: BlocBuilder<CollectionsBloc, CollectionsState>(
        builder: (context, state) {
          return Portal(
            child: Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 24),
                  if (favourites.isEmpty &&
                      ownQuotes.isEmpty &&
                      histories.isEmpty &&
                      searchQuotes.isEmpty) ...[
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: Placeholder(),
                            ),
                            SizedBox(height: 20),
                            OnboardingHeading(
                              title:
                                  'You haven\'t added anything to this collection yet',

                              disableMargins: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
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
                        itemCount:
                            favourites.length +
                            ownQuotes.length +
                            histories.length +
                            searchQuotes.length,
                        itemBuilder: (context, index) {
                          // Calculate which list the index belongs to
                          final favouriteIndex = index;
                          final ownQuoteIndex = index - favourites.length;
                          final historyIndex =
                              index - favourites.length - ownQuotes.length;
                          final searchIndex =
                              index -
                              favourites.length -
                              ownQuotes.length -
                              histories.length;

                          // Determine which entity to pass based on index
                          FavouriteEntity? favouriteEntity;
                          OwnQuoteEntity? ownQuoteEntity;
                          HistoryEntity? historyEntity;
                          SearchEntity? searchEntity;

                          if (index < favourites.length) {
                            favouriteEntity = favourites[favouriteIndex];
                          } else if (index <
                              favourites.length + ownQuotes.length) {
                            ownQuoteEntity = ownQuotes[ownQuoteIndex];
                          } else if (index <
                              favourites.length +
                                  ownQuotes.length +
                                  histories.length) {
                            historyEntity = histories[historyIndex];
                          } else {
                            searchEntity = searchQuotes[searchIndex];
                          }

                          return FavouriteListItem(
                            favouriteEntity: favouriteEntity,
                            ownQuoteEntity: ownQuoteEntity,
                            historyEntity: historyEntity,
                            searchEntity: searchEntity,
                            onDeletePressed: () {
                              context.read<CollectionsBloc>().add(
                                OnDeleteQuotePressed(
                                  favourites[index].id,
                                  widget.collectionId,
                                ),
                              );
                            },
                            onAddToCollectionPressed: () async {
                              await showModalBottomSheet(
                                context:
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).context,
                                builder:
                                    (ctx) => CollectionSelectionBottomSheet(
                                      favouriteId: favouriteEntity?.id,
                                      ownQuoteId: ownQuoteEntity?.id,
                                      quoteId: historyEntity?.id,
                                      onFavouritesUpdated:
                                          (favourites, collections) {},
                                    ),
                                isScrollControlled: true,
                                useSafeArea: true,
                              );
                              if (mounted && context.mounted) {
                                context.read<CollectionsBloc>().add(
                                  GetFavouritesOfCollection(
                                    widget.collectionId,
                                  ),
                                );
                                context.read<CollectionsBloc>().add(
                                  GetOwnQuotesOfCollection(widget.collectionId),
                                );
                                context.read<CollectionsBloc>().add(
                                  GetHistoryOfCollection(widget.collectionId),
                                );
                              }
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
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
