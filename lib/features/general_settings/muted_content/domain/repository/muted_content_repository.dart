import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';

abstract class MutedContentRepository {
  Future<Either<Failure, void>> updateMutedContent(
    List<MutedContentEntity> mutedContent,
  );

  Either<Failure, List<MutedContentEntity>> getMutedContent();
}
