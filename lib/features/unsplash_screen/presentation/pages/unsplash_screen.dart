import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:sureline/features/unsplash_screen/presentation/bloc/photo_bloc.dart';
import 'package:sureline/features/unsplash_screen/presentation/bloc/photo_event.dart';
import 'package:sureline/features/unsplash_screen/presentation/bloc/photo_state.dart';
import 'package:sureline/features/unsplash_screen/presentation/widget/photo_grid_item.dart';
import 'package:sureline/features/unsplash_screen/presentation/widget/photos_search_bar.dart';

class UnsplashScreen extends StatefulWidget {
  const UnsplashScreen({super.key});

  @override
  State<UnsplashScreen> createState() => _UnsplashScreenState();
}

class _UnsplashScreenState extends State<UnsplashScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<PhotoEntity> _photos = [];
  List<PhotoEntity> _searchedPhotos = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<PhotoBloc>()..add(GetPhotos())),
      ],
      child: BlocListener<PhotoBloc, PhotoState>(
        listener: (context, state) {
          if (state is GotPhotos) {
            _photos = (state.result);
          }
          if (state is SearchedPhotos) {
            _searchedPhotos = (state.result);
          }
        },
        child: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.close_rounded,
                                    size: 30,
                                    color: AppColors.primaryColor,
                                  ),
                                ),

                                Text(
                                  'Unsplash stock',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                size: 30,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: PhotosSearchBar(
                            controller:
                                _searchController..addListener(() {
                                  context.read<PhotoBloc>().add(
                                    ListenSearchController(
                                      _searchController.text,
                                    ),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(height: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: MasonryGridView.count(
                              controller:
                                  _scrollController..addListener(() {
                                    context.read<PhotoBloc>().add(
                                      OnScrollPositionChange(
                                        _scrollController.position.pixels,
                                        _scrollController
                                            .position
                                            .maxScrollExtent,
                                      ),
                                    );
                                  }),
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              itemCount:
                                  (_searchController.text.isEmpty)
                                      ? _photos.length
                                      : _searchedPhotos.length,
                              itemBuilder: (context, index) {
                                final photo =
                                    (_searchController.text.isEmpty)
                                        ? _photos[index]
                                        : _searchedPhotos[index];

                                return PhotoGridItem(
                                  photo: photo,
                                  onClick:
                                      () => Navigator.of(context).pop(photo),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
