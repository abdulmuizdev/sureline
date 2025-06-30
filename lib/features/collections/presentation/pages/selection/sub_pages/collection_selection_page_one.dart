import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/collections/presentation/widgets/collection_selection_list_item.dart';
import 'package:sureline/features/favourites/domain/entity/favourite_entity.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

class CollectionSelectionPageOne extends StatefulWidget {
  final int? favouriteId;
  final int? ownQuoteId;
  final Function(List<FavouriteEntity>, List<CollectionEntity>)?
  onFavouritesUpdated;
  final Function(List<OwnQuoteEntity>, List<CollectionEntity>)?
  onOwnQuotesUpdated;
  final bool shouldReloadCollections;
  const CollectionSelectionPageOne({
    super.key,
    this.favouriteId,
    this.ownQuoteId,
    this.onFavouritesUpdated,
    this.onOwnQuotesUpdated,
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
        if (state is GotCollectionsOfFavourite) {
          _selectedCollections = state.collections ?? [];
        }
        if (state is GotCollectionsOfOwnQuote) {
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
