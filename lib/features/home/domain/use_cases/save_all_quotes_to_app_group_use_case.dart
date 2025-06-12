import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class SaveAllQuotesToAppGroupUseCase {
  final QuoteRepository repository;
  SaveAllQuotesToAppGroupUseCase(this.repository);

  Future<Either<Failure, void>> execute() {
    return repository.saveAllQuotesToAppGroup();
  }
}