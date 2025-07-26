import 'package:dartz/dartz.dart';
import 'package:sureline/common/domain/entities/collections/history_entity.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/preferenecs/history/data/data_source/history_data_source.dart';
import 'package:sureline/features/preferenecs/history/domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryDataSource historyDataSource;

  HistoryRepositoryImpl(this.historyDataSource);
  @override
  Future<Either<Failure, List<HistoryEntity>>> getHistory({required bool isPremium}) async {
    return historyDataSource.getHistory(isPremium: isPremium);
  }
}
