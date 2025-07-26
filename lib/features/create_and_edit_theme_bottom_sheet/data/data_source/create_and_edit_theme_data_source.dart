/// Data source for theme creation operations.
///
/// Handles photo download and file management for themes.

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

/// Abstract data source for theme creation operations.
abstract class CreateThemeDataSource {
  /// Downloads a photo from the given URL.
  ///
  /// [url]: URL of the photo to download
  /// Returns: Either a failure or the local file path
  Future<Either<Failure, String>> downloadPhoto(String url);
}

/// Implementation of create theme data source.
class CreateThemeDataSourceImpl extends CreateThemeDataSource {
  final http.Client client;
  CreateThemeDataSourceImpl(this.client);

  @override
  Future<Either<Failure, String>> downloadPhoto(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final fileName = path.basename(url);
        final file = File('${dir.path}/themes/$fileName.png');

        // Create themes directory if it doesn't exist
        await Directory('${dir.path}/themes').create(recursive: true);

        await file.writeAsBytes(response.bodyBytes);
        final finalPath = file.path;
        return Right(finalPath);
      } else {
        debugPrint('${response.statusCode}');
        return Left(UnknownFailure());
      }
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }
}
