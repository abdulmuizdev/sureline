import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/preferenecs/collections/presentation/widgets/collection_selection_list_item.dart';
import 'package:sureline/features/preferenecs/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/preferenecs/history/domain/entity/history_entity.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/entity/own_quote_entity.dart';
import 'package:sureline/features/preferenecs/search/domain/entity/search_entity.dart';

class CollectionSelectionPageOne extends StatefulWidget {
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
  final bool shouldReloadCollections;
  const CollectionSelectionPageOne({
    super.key,
    this.favouriteId,
    this.ownQuoteId,
    this.quoteId,
    this.searchId,
    this.onFavouritesUpdated,
    this.onOwnQuotesUpdated,
    this.onHistoryUpdated,
    this.onSearchUpdated,
    required this.shouldReloadCollections,
  });

  @override
  State<CollectionSelectionPageOne> createState() =>
      _CollectionSelectionPageOneState();
}

class _CollectionSelectionPageOneState
    extends State<CollectionSelectionPageOne> {
  List<CollectionEntity> _collections = [];
  List<CollectionEntity> _selectedCollections = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CollectionsBloc>().add(GetCollections());
        if (widget.favouriteId != null) {
          context.read<CollectionsBloc>().add(
            GetCollectionsOfFavourite(widget.favouriteId!),
          );
        }
        if (widget.ownQuoteId != null) {
          context.read<CollectionsBloc>().add(
            GetCollectionsOfOwnQuote(widget.ownQuoteId!),
          );
        }
        if (widget.quoteId != null) {
          context.read<CollectionsBloc>().add(
            GetCollectionsOfHistory(widget.quoteId!),
          );
        }
        if (widget.searchId != null) {
          context.read<CollectionsBloc>().add(
            GetCollectionsOfSearch(widget.searchId!),
          );
        }
      }
    });
  }

  @override
  void didUpdateWidget(covariant CollectionSelectionPageOne oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.shouldReloadCollections != widget.shouldReloadCollections) {
      context.read<CollectionsBloc>().add(GetCollections());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CollectionsBloc, CollectionsState>(
      listener: (context, state) {
        if (state is GotCollections) {
          _collections = state.collections ?? [];
        }
        if (state is SavedCollection) {
          // Refresh collections when a new collection is saved
          _collections = state.collections;
          print(
            'Collection saved, updated selection list with ${_collections.length} collections',
          );
        }
        if (state is GotCollectionsOfFavourite) {
          _selectedCollections = state.collections ?? [];
        }
        if (state is GotCollectionsOfOwnQuote) {
          _selectedCollections = state.collections ?? [];
        }
        if (state is GotCollectionsOfHistory) {
          _selectedCollections = state.collections ?? [];
        }
        if (state is GotCollectionsOfSearch) {
          _selectedCollections = state.collections ?? [];
        }
        if (state is GotFavouritesOfCollectionAndCollectionsOfFavourite) {
          _selectedCollections = state.collections;
          widget.onFavouritesUpdated?.call(state.favourites, state.collections);
        }
        if (state is GotOwnQuotesOfCollectionAndCollectionsOfOwnQuote) {
          _selectedCollections = state.collections;
          widget.onOwnQuotesUpdated?.call(state.ownQuotes, state.collections);
        }
        if (state is GotHistoryOfCollectionAndCollectionsOfHistory) {
          _selectedCollections = state.collections;
          widget.onHistoryUpdated?.call(state.history, state.collections);
        }
        if (state is GotSearchOfCollectionAndCollectionsOfSearch) {
          _selectedCollections = state.collections;
          widget.onSearchUpdated?.call(state.search, state.collections);
        }
      },
      child: BlocBuilder<CollectionsBloc, CollectionsState>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(18),
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Saved',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: _collections.length,
                    itemBuilder: (context, index) {
                      final collection = _collections[index];
                      final isSelected = _selectedCollections.any(
                        (element) => element.name == collection.name,
                      );

                      return CollectionSelectionListItem(
                        isFirst: index == 0,
                        isLast: index == _collections.length - 1,
                        entity: collection,
                        isSelected: isSelected,
                        onSelected: () {
                          context.read<CollectionsBloc>().add(
                            OnAddToCollectionPressed(
                              collectionId: collection.id,
                              isSelected: !isSelected,
                              favouriteId: widget.favouriteId,
                              ownQuoteId: widget.ownQuoteId,
                              quoteId: widget.quoteId,
                              searchId: widget.searchId,
                            ),
                          );
                        },
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
