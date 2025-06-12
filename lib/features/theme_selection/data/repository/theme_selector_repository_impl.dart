import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/model/create_and_edit_theme_model.dart';
import 'package:sureline/features/theme_selection/data/data_source/theme_data_source.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';

class ThemeSelectorRepositoryImpl extends ThemeSelectorRepository {
  final ThemeDataSource themeDataSource;

  ThemeSelectorRepositoryImpl(this.themeDataSource);

  @override
  Future<Either<Failure, List<ThemeEntity>>> getThemes() async {
    final result = await themeDataSource.getThemes();
    return result.fold(
      (left) {
        return Left(left);
      },
      (right) {
        return Right(
          right.map((model) => ThemeEntity.fromModel(model)).toList(),
        );
      },
    );
  }

  @override
  Future<Either<Failure, List<ThemeEntity>>> getThemesMixes() {
    return themeDataSource.getThemesMixes();
  }

  @override
  Future<Either<Failure, void>> changeTheme(ThemeEntity entity) {
    return themeDataSource.changeTheme(ThemeModel.fromEntity(entity));
  }

  @override
  Future<Either<Failure, void>> setTheme() {
    return themeDataSource.setTheme();
  }
}
