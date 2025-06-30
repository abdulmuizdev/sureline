import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';
import 'package:sureline/features/general_settings/muted_content/domain/repository/muted_content_repository.dart';

class UpdateMutedContentUseCase {
  final MutedContentRepository repository;

  UpdateMutedContentUseCase(this.repository);

  Future<Either<Failure, void>> execute(List<MutedContentEntity> mutedContent) {
    return repository.updateMutedContent(mutedContent);
  }
}
