import 'package:sureline/features/share/domain/repository/share_repository.dart';

class DisposeStreamUseCase {
  final ShareRepository repository;
  
  DisposeStreamUseCase(this.repository);
  
  void execute(){
    return repository.disposeStream();
  }
}