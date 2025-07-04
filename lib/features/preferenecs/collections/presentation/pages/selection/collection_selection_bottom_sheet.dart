import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/bottom_sheet_app_bar.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/sub_pages/create_collection_page.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/selection/sub_pages/collection_selection_page_one.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

class CollectionSelectionBottomSheet extends StatefulWidget {
  final int? favouriteId;
  final int? ownQuoteId;
  final int? quoteId;
  final int? searchId;
  final Function(List<FavouriteEntity>, List<CollectionEntity>)?
  onFavouritesUpdated;
  final Function(List<OwnQuoteEntity>, List<CollectionEntity>)?
  onOwnQuotesUpdated;
  final Function(List<HistoryEntity>, List<CollectionEntity>)? onHistoryUpdated;
  final Function(List<SearchEntity>, List<CollectionEntity>)? onSearchUpdated;

  const CollectionSelectionBottomSheet({
    super.key,
    this.favouriteId,
    this.ownQuoteId,
    this.quoteId,
    this.searchId,
    this.onFavouritesUpdated,
    this.onOwnQuotesUpdated,
    this.onHistoryUpdated,
    this.onSearchUpdated,
  });

  @override
  State<CollectionSelectionBottomSheet> createState() =>
      _CollectionSelectionBottomSheetState();
}

class _CollectionSelectionBottomSheetState
    extends State<CollectionSelectionBottomSheet> {
  List<CollectionEntity> _collections = [];
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String _appBarTitle = 'Close';
  bool _isAddNewVisible = true;
  bool _shouldReloadCollections = false;

  @override
  void initState() {
    super.initState();
    _navigatorKey.currentState?.setState(() {});
  }

  void _handleBack() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      setState(() {
        _appBarTitle = 'Close';
      });
      _navigatorKey.currentState?.pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionsBloc, CollectionsState>(
      listener: (context, state) {
        if (state is GotCollections) {
          _collections.addAll(state.collections ?? []);
        }
        if (state is SavedCollection) {
          // Refresh collections when a new collection is saved
          _collections = state.collections;
          print(
            'Collection saved, updated selection bottom sheet with ${_collections.length} collections',
          );
        }
      },
      child: BlocBuilder<CollectionsBloc, CollectionsState>(
        builder: (context, state) {
          return Container(
            decoration: Utils.bottomSheetDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: AppColors.white,
                        child: BottomSheetAppBar(
                          title: _appBarTitle,
                          onBack: _handleBack,
                          showIcon: !_isAddNewVisible,
                          showText: _isAddNewVisible,
                        ),
                      ),
                      if (_isAddNewVisible)
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              _appBarTitle = 'Close';
                            });
                            setState(() {
                              _isAddNewVisible = false;
                            });
                            final udpatedCollections = await _navigatorKey
                                .currentState
                                ?.push<List<CollectionEntity>?>(
                                  CupertinoPageRoute(
                                    builder:
                                        (context) =>
                                            const CreateCollectionPage(),
                                  ),
                                );

                            setState(() {
                              _collections = udpatedCollections ?? [];
                              _shouldReloadCollections = true;
                            });
                            setState(() {
                              _isAddNewVisible = true;
                            });
                          },
                          child: const Text(
                            'Add new',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                Expanded(
                  child: Navigator(
                    key: _navigatorKey,
                    onGenerateRoute: (settings) {
                      return CupertinoPageRoute(
                        builder:
                            (context) => CollectionSelectionPageOne(
                              shouldReloadCollections: _shouldReloadCollections,
                              favouriteId: widget.favouriteId,
                              ownQuoteId: widget.ownQuoteId,
                              quoteId: widget.quoteId,
                              searchId: widget.searchId,
                              onFavouritesUpdated: (favourites, collections) {
                                widget.onFavouritesUpdated?.call(
                                  favourites,
                                  collections,
                                );
                              },
                              onHistoryUpdated: (histories, collections) {
                                widget.onHistoryUpdated?.call(
                                  histories,
                                  collections,
                                );
                              },
                              onOwnQuotesUpdated: (ownQuotes, collections) {
                                widget.onOwnQuotesUpdated?.call(
                                  ownQuotes,
                                  collections,
                                );
                              },
                              onSearchUpdated: (search, collections) {
                                widget.onSearchUpdated?.call(
                                  search,
                                  collections,
                                );
                              },
                            ),
                        settings: settings,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
