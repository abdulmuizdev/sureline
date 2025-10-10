/// Implementation of create theme repository.
///
/// Delegates operations to the data source layer.

import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/data_source/create_and_edit_theme_data_source.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/repository/create_and_edit_theme_repository.dart';

/// Implementation of the create theme repository.
class CreateThemeRepositoryImpl extends CreateThemeRepository {
  final CreateThemeDataSource dataSource;

  /// Creates a new CreateThemeRepositoryImpl instance.
  CreateThemeRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> downloadPhoto(String url) {
    return dataSource.downloadPhoto(url);
  }
}
