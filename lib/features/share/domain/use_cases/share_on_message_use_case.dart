import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';

class ShareOnMessageUseCase {
  final ShareRepository repository;
  ShareOnMessageUseCase(this.repository);

  Future<Either<Failure, void>> execute(ShareEntity entity){
    return repository.shareOnMessage(entity);
  }
}