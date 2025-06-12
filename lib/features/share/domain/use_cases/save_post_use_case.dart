import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

class SavePostUseCase {
  final ShareRepository repository;

  SavePostUseCase(this.repository);

  Future<Either<Failure, void>> execute(String path){
    return repository.saveFile(path);
  }
}