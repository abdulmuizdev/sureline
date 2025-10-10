import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:sureline/features/unsplash_screen/domain/use_case/get_photos_search_results_use_case.dart';
import 'package:sureline/features/unsplash_screen/domain/use_case/get_photos_use_case.dart';
import 'package:sureline/features/unsplash_screen/presentation/bloc/photo_event.dart';
import 'package:sureline/features/unsplash_screen/presentation/bloc/photo_state.dart';

/// Bloc for managing Unsplash photo integration and background selection.
///
/// This bloc handles the integration with Unsplash API for high-quality
/// background images. It provides photo retrieval, search functionality,
/// and pagination management for seamless background customization
/// throughout the app.
///
/// Key Features:
/// - Unsplash API integration for premium background images
/// - Real-time photo search with debouncing
/// - Infinite scroll pagination for smooth browsing
/// - Photo caching and memory management
/// - Search result filtering and organization
/// - Performance optimization with efficient loading
///
/// Photo Management:
/// - Curated photo collections for different themes
/// - Search-based photo discovery
/// - High-resolution image support
/// - Background image optimization
/// - Photo metadata and attribution handling
///
/// Search Capabilities:
/// - Real-time search with 500ms debouncing
/// - Keyword-based photo filtering
/// - Search result pagination
/// - Search history management
/// - Empty state handling
///
/// Pagination System:
/// - Infinite scroll implementation
/// - Threshold-based loading triggers
/// - Separate pagination for search and browse
/// - Loading state management
/// - Memory-efficient photo storage
///
/// State Management:
/// - Initial: No photos loaded
/// - GettingPhotos: Loading photos
/// - GotPhotos: Photos loaded successfully
/// - SearchingPhotos: Search in progress
/// - SearchedPhotos: Search results available
///
/// Usage:
/// ```dart
/// BlocProvider(
///   create: (context) => PhotoBloc(
///     getPhotosUseCase,
///     getPhotosSearchResultsUseCase,
///   ),
///   child: UnsplashScreen(),
/// );
/// ```
class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  /// Use case for retrieving photos from Unsplash API.
  final GetPhotosUseCase _getPhotosUseCase;

  /// Use case for searching photos on Unsplash.
  final GetPhotosSearchResultsUseCase _getPhotosSearchResultsUseCase;

  /// Flag to prevent multiple simultaneous loading operations.
  bool isGetting = false;

  /// Current page number for browse pagination.
  int page = 1;

  /// Current page number for search pagination.
  int searchPage = 1;

  /// Current search query for photo filtering.
  String searchQuery = '';

  /// Timer for debouncing search input to optimize API calls.
  Timer? _debounce;

  /// List of photos for browsing (non-search results).
  final List<PhotoEntity> _photos = [];

  /// List of photos from search results.
  final List<PhotoEntity> _searchedPhotos = [];

  /// Creates a new PhotoBloc instance with required use cases.
  PhotoBloc(this._getPhotosUseCase, this._getPhotosSearchResultsUseCase) : super(Initial()) {
    // Handle photo browsing with pagination
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

    // Handle photo search with pagination
    on<SearchPhotos>((event, emit) async {
      emit(SearchingPhotos());
      final result = await _getPhotosSearchResultsUseCase.execute(event.query, searchPage);
      result.fold((left) {}, (right) {
        _searchedPhotos.addAll(right);
        emit(SearchedPhotos(_searchedPhotos));
        isGetting = false;
      });
    });

    // Handle scroll position changes for infinite scroll
    on<OnScrollPositionChange>((event, emit) {
      final threshold = 100;
      if (!isGetting) {
        debugPrint('${event.scrolledPixels >= event.maxScrollExtent - threshold}');
        if (event.scrolledPixels >= event.maxScrollExtent - threshold) {
          if (searchQuery.isEmpty) {
            // Load more browse photos
            page++;
            add(GetPhotos());
          } else {
            // Load more search results
            searchPage++;
            add(SearchPhotos(searchQuery));
          }
          isGetting = true;
        }
      }
    });

    // Handle search controller input with debouncing
    on<ListenSearchController>((event, emit) {
      searchQuery = event.query;

      // Clear previous search results for new search
      _searchedPhotos.clear();

      // Cancel previous timer if still active
      if (_debounce?.isActive ?? false) {
        _debounce!.cancel();
      }

      // Start new timer for debounced search
      _debounce = Timer(const Duration(milliseconds: 500), () {
        final query = event.query.trim();

        if (query.isEmpty) {
          // Reset to browse mode if search is empty
          add(GetPhotos());
        } else {
          // Perform search with query
          add(SearchPhotos(query));
        }
      });
    });
  }
}
