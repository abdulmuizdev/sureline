import 'package:sureline/features/share/domain/repository/share_repository.dart';

/// Cleans up rendering streams and resources to prevent memory leaks.
///
/// Essential for maintaining app performance during video rendering operations.
/// Handles stream disposal, memory deallocation, and temporary file cleanup.
class DisposeStreamUseCase {
  DisposeStreamUseCase(this.repository);
  final ShareRepository repository;


  /// Disposes rendering streams and cleans up associated resources.
  void execute() {
    return repository.disposeStream();
  }
}
