import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';

class IsFeedSetupShownUseCase {
  final QuoteRepository quoteRepository;

  IsFeedSetupShownUseCase(this.quoteRepository);

  Future<Either<Failure, bool>> execute() {
    return quoteRepository.isFeedSetupShown();
  }
}