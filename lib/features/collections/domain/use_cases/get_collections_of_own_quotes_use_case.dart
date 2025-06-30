import 'package:dartz/dartz.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/domain/repository/collections_repository.dart';

class GetCollectionsOfOwnQuotesUseCase {
  final CollectionsRepository repository;

  GetCollectionsOfOwnQuotesUseCase(this.repository);

  Future<Either<Failure, List<CollectionEntity>>> call(int ownQuoteId) {
    return repository.getCollectionsOfOwnQuote(ownQuoteId);
  }
}
