import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:sureline/features/unsplash_screen/domain/use_case/get_photos_search_results_use_case.dart';
import 'package:sureline/features/unsplash_screen/domain/use_case/get_photos_use_case.dart';
import 'package:sureline/features/unsplash_screen/presentation/bloc/photo_event.dart';
import 'package:sureline/features/unsplash_screen/presentation/bloc/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final GetPhotosUseCase _getPhotosUseCase;
  final GetPhotosSearchResultsUseCase _getPhotosSearchResultsUseCase;

  bool isGetting = false;
  int page = 1;
  int searchPage = 1;
  String searchQuery = '';

  Timer? _debounce;

  final List<PhotoEntity> _photos = [];
  final List<PhotoEntity> _searchedPhotos = [];

  PhotoBloc(this._getPhotosUseCase, this._getPhotosSearchResultsUseCase)
    : super(Initial()) {
    on<GetPhotos>((event, emit) async {
      emit(GettingPhotos());
      isGetting = true;
      final result = await _getPhotosUseCase.execute(page);
      result.fold((left) {}, (right) {
        _photos.addAll(right);
        emit(GotPhotos(_photos));
        isGetting = false;
      });
    });

    on<SearchPhotos>((event, emit) async {
      emit(SearchingPhotos());
      final result = await _getPhotosSearchResultsUseCase.execute(
        event.query,
        searchPage,
      );
      result.fold((left) {}, (right) {
        _searchedPhotos.addAll(right);
        emit(SearchedPhotos(_searchedPhotos));
        isGetting = false;
      });
    });

    on<OnScrollPositionChange>((event, emit) {
      final threshold = 100;
      if (!isGetting) {
        debugPrint(
          '${event.scrolledPixels >= event.maxScrollExtent - threshold}',
        );
        if (event.scrolledPixels >= event.maxScrollExtent - threshold) {
          if (searchQuery.isEmpty) {
            page++;
            add(GetPhotos());
          } else {
            searchPage++;
            add(SearchPhotos(searchQuery));
          }
          isGetting = true;
        }
      }
    });

    on<ListenSearchController>((event, emit) {
      searchQuery = event.query;

      _searchedPhotos.clear();

      // Cancel previous timer if still active
      if (_debounce?.isActive ?? false) {
        _debounce!.cancel();
      }

      // Start new timer
      _debounce = Timer(const Duration(milliseconds: 500), () {
        final query = event.query.trim();

        if (query.isEmpty) {
          add(GetPhotos());
        } else {
          add(SearchPhotos(query));
        }
      });
    });
  }
}
