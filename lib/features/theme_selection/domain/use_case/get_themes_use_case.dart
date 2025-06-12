import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';

class GetThemesUseCase {
  final ThemeSelectorRepository repository;
  const GetThemesUseCase(this.repository);

  Future<Either<Failure, List<ThemeEntity>>> execute() {
    return repository.getThemes();
  }

}