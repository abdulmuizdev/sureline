import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/collections/presentation/pages/default/sub_pages/collection_detail_page.dart';
import 'package:sureline/features/collections/presentation/pages/default/sub_pages/create_collection_page.dart';
import 'package:sureline/features/collections/presentation/widgets/collection_list_item.dart';
import 'package:sureline/features/search/presentation/widget/sureline_search_bar.dart';

class CollectionListPage extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onDetail;
  final bool shouldRefreshCollections;

  const CollectionListPage({
    super.key,
    required this.onNext,
    required this.onDetail,
    this.shouldRefreshCollections = false,
  });

  @override
  State<CollectionListPage> createState() => _CollectionListPageState();
}

class _CollectionListPageState extends State<CollectionListPage> {
  List<CollectionEntity> _collections = [];
  int _overlayVisibleIndex = -1;
  @override
  void initState() {
    super.initState();
    if (widget.shouldRefreshCollections) {
      print('calling bloc to refresh collections');
      context.read<CollectionsBloc>().add(GetCollections());
    }
  }

  @override
  void didUpdateWidget(covariant CollectionListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shouldRefreshCollections) {
      print('calling bloc to refresh collections');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && context.mounted) {
          context.read<CollectionsBloc>().add(GetCollections());
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('shouldRefreshCollections: ${widget.shouldRefreshCollections}');
    return BlocListener<CollectionsBloc, CollectionsState>(
      listener: (context, state) {
        if (state is GotCollections) {
          _collections = state.collections ?? [];
          print(
            (_collections.length > 0)
                ? '${_collections[0].ownQuotes.length} and ${_collections[0].favouriteQuotes.length}'
                : '',
          );
        }
      },
      child: BlocBuilder<CollectionsBloc, CollectionsState>(
        builder: (context, state) {
          if (_collections.isEmpty) {
            return Container(
              color: AppColors.white,
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My collections',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 24),
                  Spacer(),
                  Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 100, height: 100, child: Placeholder()),
                      OnboardingHeading(
                        title: 'You don\'t have any collections yet',
                        subTitle:
                            'Create collections to group quotes you want to save together, like \'Morning motivations\' or \'Beat my fear\'',
                        disableMargins: true,
                      ),
                    ],
                  ),

                  Spacer(),
                  SurelineButton(
                    disableVerticalPadding: true,
                    text: 'Create collection',
                    onPressed: () async {
                      widget.onNext();

                      final udpatedCollections = await Navigator.of(
                        context,
                      ).push<List<CollectionEntity>?>(
                        CupertinoPageRoute(
                          builder: (context) => const CreateCollectionPage(),
                        ),
                      );
                      setState(() {
                        _collections = udpatedCollections ?? [];
                      });
                    },
                  ),
                  // Spacer(),
                ],
              ),
            );
          } else {
            return Portal(
              child: GestureDetector(
                onTap: () {
                  if (_overlayVisibleIndex >= 0) {
                    setState(() {
                      _overlayVisibleIndex = -1;
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
                          'My collections',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10),

                        Expanded(
                          child: ListView.builder(
                            itemCount: _collections.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  widget.onDetail();
                                  await Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder:
                                          (context) => CollectionDetailPage(
                                            collectionId:
                                                _collections[index].id,
                                            name: _collections[index].name,
                                            onFavouritesUpdated: () {},
                                          ),
                                    ),
                                  );
                                  print('mounted: ${mounted}');
                                  print('context.mounted: ${context.mounted}');
                                  if (mounted && context.mounted) {
                                    print(
                                      'calling bloc to refresh collections',
                                    );
                                    context.read<CollectionsBloc>().add(
                                      GetCollections(),
                                    );
                                  }
                                },
                                child: CollectionListItem(
                                  entity: _collections[index],
                                  onDeletePressed: () {
                                    setState(() {
                                      _overlayVisibleIndex = -1;
                                    });
                                    context.read<CollectionsBloc>().add(
                                      OnDeletePressed(_collections[index]),
                                    );
                                  },
                                  onOverlayToggled: (value) {
                                    if (value) {
                                      setState(() {
                                        _overlayVisibleIndex = index;
                                      });
                                    } else {
                                      setState(() {
                                        _overlayVisibleIndex = -1;
                                      });
                                    }
                                  },
                                  isOverlayVisible:
                                      _overlayVisibleIndex == index,
                                ),
                              );
                            },
                          ),
                        ),
                        SurelineButton(
                          text: 'Add collection',
                          onPressed: () async {
                            widget.onNext();
                            final udpatedCollections = await Navigator.of(
                              context,
                            ).push<List<CollectionEntity>?>(
                              CupertinoPageRoute(
                                builder:
                                    (context) => const CreateCollectionPage(),
                              ),
                            );
                            setState(() {
                              _collections = udpatedCollections ?? [];
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
    );
  }
}
