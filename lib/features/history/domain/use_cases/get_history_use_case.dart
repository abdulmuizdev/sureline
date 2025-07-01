import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/history/domain/repository/history_repository.dart';
import 'package:sureline/features/history/domain/entity/history_entity.dart';

class GetHistoryUseCase {
  final HistoryRepository historyRepository;

  GetHistoryUseCase(this.historyRepository);

  Future<Either<Failure, List<HistoryEntity>>> call() async {
    return await historyRepository.getHistory();
  }
}
