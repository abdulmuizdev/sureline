import 'package:sureline/features/share/data/data_source/share_data_source.dart';
import 'package:sureline/features/share/domain/entity/render_result_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

/// Provides real-time rendering progress stream for video/image creation.
///
/// Enables progress tracking and user feedback during long-running
/// rendering operations. Stream includes percentage updates and completion events.
class GetRenderResultsStreamUseCase {
  final ShareRepository repository;

  GetRenderResultsStreamUseCase(this.repository);

  /// Returns stream of rendering progress updates.
  ///
  /// Stream provides: progress percentage, current stage, error states, completion events
  /// Returns: Stream of RenderResultEntity with progress data
  Stream<RenderResultEntity> execute() {
    return repository.renderResultStream();
  }
}
