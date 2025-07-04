import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:sureline/common/presentation/widgets/onboarding_heading.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/preferenecs/collections/presentation/widgets/collection_list_item.dart';
import 'package:sureline/features/preferenecs/search/presentation/widget/sureline_search_bar.dart';

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
  int _overlayVisibleIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && context.mounted) {
        context.read<CollectionsBloc>().add(GetCollections());
      }
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.shouldRefreshCollections) {
  //     print('calling bloc to refresh collections');
  //     context.read<CollectionsBloc>().add(GetCollections());
  //   }
  // }

  // @override
  // void didUpdateWidget(covariant CollectionListPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.shouldRefreshCollections) {
  //     print('calling bloc to refresh collections');
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       if (mounted && context.mounted) {
  //         context.read<CollectionsBloc>().add(GetCollections());
  //       }
  //     });
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Always refresh collections when this page becomes visible
  //   context.read<CollectionsBloc>().add(GetCollections());
  // }

  List<CollectionEntity> collections = [];

  @override
  Widget build(BuildContext context) {
    print('shouldRefreshCollections: ${widget.shouldRefreshCollections}');
    return BlocListener<CollectionsBloc, CollectionsState>(
      listener: (context, state) {
        if (state is GotCollections) {
          collections = state.collections ?? [];
        }
      },
      child: BlocBuilder<CollectionsBloc, CollectionsState>(
        builder: (context, state) {
          if (collections.isEmpty) {
            return Container(
              color: AppColors.white,
              padding: const EdgeInsets.only(left: 18, right: 18),
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
                    text: 'Create collection',
                    onPressed: () async {
                      widget.onNext();
                      context.push('/collections/create');
                    },
                  ),
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
                    padding: const EdgeInsets.only(left: 18, right: 18),
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
                        SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: collections.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  widget.onDetail();
                                  final collection = collections[index];
                                  final encodedName = Uri.encodeComponent(
                                    collection.name,
                                  );
                                  context.push(
                                    '/collections/detail/${collection.id}/$encodedName',
                                  );
                                  // Refresh collections after returning from detail page
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
                                  entity: collections[index],
                                  onDeletePressed: () {
                                    setState(() {
                                      _overlayVisibleIndex = -1;
                                    });
                                    context.read<CollectionsBloc>().add(
                                      OnDeletePressed(collections[index]),
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
                            context.push('/collections/create');
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
