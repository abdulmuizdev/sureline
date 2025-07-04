import 'package:flutter/cupertino.dart';
import 'package:sureline/features/preferenecs/collections/data/model/collection_model.dart';
import 'package:sureline/features/preferenecs/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';

class QuoteModel extends QuoteEntity {
  final List<CollectionModel> collections;
  QuoteModel({
    required super.quote,
    required super.author,
    required super.isLiked,
    required super.isOwnQuote,
    required super.quoteKey,
    required super.likedAt,
    required this.collections,
  }) : super(collections: collections);

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quote: json['q_text'],
      author: json['author'],
      isLiked: json['isLiked'] ?? false,
      isOwnQuote: json['isOwnQuote'] ?? false,
      likedAt:
          (json['likedAt'] != null) ? DateTime.tryParse(json['likedAt']) : null,
      quoteKey: GlobalKey(),
      collections:
          (json['collections'] != null)
              ? (json['collections'] as List<dynamic>)
                  .map(
                    (e) => CollectionModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList()
              : [],
    );
  }

  @override
  QuoteModel copyWith({
    String? author,
    String? quote,
    bool? isLiked,
    bool? isOwnQuote,
    DateTime? likedAt,
    List<CollectionEntity>? collections,
  }) {
    return QuoteModel(
      quote: quote ?? this.quote,
      author: author ?? this.author,
      isLiked: isLiked ?? this.isLiked,
      isOwnQuote: isOwnQuote ?? this.isOwnQuote,
      likedAt: likedAt ?? this.likedAt,
      quoteKey: quoteKey,
      collections:
          collections?.map((e) => CollectionModel.fromEntity(e)).toList() ??
          this.collections,
    );
  }

  factory QuoteModel.fromEntity(QuoteEntity entity) {
    return QuoteModel(
      quote: entity.quote,
      author: entity.author,
      isLiked: entity.isLiked,
      isOwnQuote: entity.isOwnQuote,
      likedAt: entity.likedAt,
      quoteKey: entity.quoteKey,
      collections:
          entity.collections.map((e) => CollectionModel.fromEntity(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'q_text': quote,
      'author': author,
      'isLiked': isLiked,
      'isOwnQuote': isOwnQuote,
      'likedAt': likedAt?.toIso8601String(),
      'collections': collections.map((e) => e.toJson()).toList(),
    };
  }
}
