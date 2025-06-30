import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/general_settings/muted_content/data/data_source/muted_content_data_source.dart';
import 'package:sureline/features/general_settings/muted_content/data/model/muted_content_model.dart';
import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';
import 'package:sureline/features/general_settings/muted_content/domain/repository/muted_content_repository.dart';

class MutedContentRepositoryImpl extends MutedContentRepository {
  final MutedContentDataSource dataSource;

  MutedContentRepositoryImpl(this.dataSource);

  @override
  Either<Failure, List<MutedContentEntity>> getMutedContent() {
    return dataSource.getMutedContent();
  }

  @override
  Future<Either<Failure, void>> updateMutedContent(
    List<MutedContentEntity> mutedContent,
  ) {
    return dataSource.updateMutedContent(
      mutedContent.map((entity) => MutedContentModel.fromEntity(entity)).toList(),
    );
  }
}
