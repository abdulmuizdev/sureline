import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/unsplash_screen/data/model/photo_model.dart';
import 'package:http/http.dart' as http;

abstract class PhotoDataSource {
  Future<Either<Failure, List<PhotoModel>>> getPhotos(int page);
  Future<Either<Failure, List<PhotoModel>>> searchPhotos(
    String query,
    int page,
  );
}

class PhotoDataSourceImpl extends PhotoDataSource {
  final http.Client client;

  PhotoDataSourceImpl(this.client);

  @override
  Future<Either<Failure, List<PhotoModel>>> getPhotos(int page) async {
    try {
      final response = await client.get(
        Uri.parse(
          'https://api.unsplash.com/collections/317099/photos?per_page=30&page=$page&client_id=V76dVrrU4bXJ8riez2h4hafMr0xOrq7lWFKhGdBxQXQ',
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> raw = json.decode(response.body);
        List<PhotoModel> photos =
            raw.map((json) => PhotoModel.fromJson(json)).toList();
        return Right(photos);
      } else {
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<PhotoModel>>> searchPhotos(
    String query,
    int page,
  ) async {
    try {
      final response = await client.get(
        Uri.parse(
          'https://api.unsplash.com/search/photos?query=$query&per_page=30&page=$page&client_id=V76dVrrU4bXJ8riez2h4hafMr0xOrq7lWFKhGdBxQXQ',
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> raw = json.decode(response.body)['results'];
        List<PhotoModel> photos =
            raw.map((json) => PhotoModel.fromJson(json)).toList();
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
