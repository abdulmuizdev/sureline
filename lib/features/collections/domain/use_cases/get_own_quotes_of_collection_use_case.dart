import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/domain/repository/collections_repository.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

class GetOwnQuotesOfCollectionUseCase {
  final CollectionsRepository repository;

  GetOwnQuotesOfCollectionUseCase(this.repository);

  Future<Either<Failure, List<OwnQuoteEntity>>> execute(
    int collectionId,
  ) async {
    return repository.getOwnQuotesOfCollection(collectionId);
  }
}
