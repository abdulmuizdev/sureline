import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/data_source/create_and_edit_theme_data_source.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/repository/create_and_edit_theme_repository.dart';

class CreateThemeRepositoryImpl extends CreateThemeRepository {
  final CreateThemeDataSource dataSource;
  CreateThemeRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, String>> downloadPhoto(String url) {
    return dataSource.downloadPhoto(url);
  }
}
