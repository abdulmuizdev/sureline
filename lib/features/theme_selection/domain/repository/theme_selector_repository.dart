import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/error/failures.dart';

abstract class ThemeSelectorRepository {
  Future<Either<Failure, List<ThemeEntity>>> getThemes();
  Future<Either<Failure, List<ThemeEntity>>> getThemesMixes();
  Future<Either<Failure, void>> changeTheme(ThemeEntity entity);
  Future<Either<Failure, void>> setTheme();
}