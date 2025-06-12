import 'package:sureline/features/share/data/data_source/share_data_source.dart';
import 'package:sureline/features/share/domain/entity/render_result_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

class GetRenderResultsStreamUseCase {
  final ShareRepository repository;

  GetRenderResultsStreamUseCase(this.repository);

  Stream<RenderResultEntity> execute() {
    return repository.renderResultStream();
  }
}