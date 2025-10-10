import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/unsplash_screen/data/model/photo_model.dart';
import 'package:http/http.dart' as http;

/// Abstract interface for Unsplash API photo operations.
///
/// Defines contract for photo retrieval and search with pagination support.
abstract class PhotoDataSource {
  /// Retrieves photos from Unsplash API with pagination.
  /// [page] - Page number for pagination
  /// Returns Either<Failure, List<PhotoModel>> - Photos or error
  Future<Either<Failure, List<PhotoModel>>> getPhotos(int page);

  /// Searches photos from Unsplash API with query and pagination.
  /// [query] - Search term for photo filtering
  /// [page] - Page number for pagination
  /// Returns Either<Failure, List<PhotoModel>> - Search results or error
  Future<Either<Failure, List<PhotoModel>>> searchPhotos(String query, int page);
}

/// Implementation of PhotoDataSource with HTTP client.
///
/// Handles Unsplash API integration with proper error handling and JSON parsing.
/// Manages API authentication and response processing.
class PhotoDataSourceImpl extends PhotoDataSource {
  /// HTTP client for API requests
  final http.Client client;

  /// Creates PhotoDataSourceImpl with HTTP client dependency.
  /// [client] - HTTP client for API requests
  PhotoDataSourceImpl(this.client);

  /// Retrieves photos from Unsplash collections API.
  /// Handles API response parsing and error handling.
  ///
  /// [page] - Page number for pagination
  /// Returns Either<Failure, List<PhotoModel>> - Photos or error
  @override
  Future<Either<Failure, List<PhotoModel>>> getPhotos(int page) async {
    try {
      final response = await client.get(
        Uri.parse(
          'https://api.unsplash.com/collections/317099/photos?per_page=30&page=$page&client_id=V76dVrrU4bXJ8riez2h4hafMr0xOrq7lWFKhGdBxQXQ',
        ),
      );
      if (response.statusCode == 200) {
        final raw = json.decode(response.body) as List<dynamic>;
        List<PhotoModel> photos =
            raw.map((json) => PhotoModel.fromJson(json as Map<String, dynamic>)).toList();
        return Right(photos);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  /// Searches photos from Unsplash search API.
  /// Handles search response parsing and error handling.
  ///
  /// [query] - Search term for photo filtering
  /// [page] - Page number for pagination
  /// Returns Either<Failure, List<PhotoModel>> - Search results or error
  @override
  Future<Either<Failure, List<PhotoModel>>> searchPhotos(String query, int page) async {
    try {
      final response = await client.get(
        Uri.parse(
          'https://api.unsplash.com/search/photos?query=$query&per_page=30&page=$page&client_id=V76dVrrU4bXJ8riez2h4hafMr0xOrq7lWFKhGdBxQXQ',
        ),
      );
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        final raw = responseBody['results'] as List<dynamic>;
        List<PhotoModel> photos =
            raw.map((json) => PhotoModel.fromJson(json as Map<String, dynamic>)).toList();
        return Right(photos);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }
}
