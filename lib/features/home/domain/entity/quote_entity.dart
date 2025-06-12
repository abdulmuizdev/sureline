import 'package:flutter/cupertino.dart';
import 'package:sureline/features/home/data/model/quote_model.dart';

class QuoteEntity {
  final String author;
  final String quote;
  final bool isLiked;
  final bool isOwnQuote;
  final GlobalKey quoteKey;
  final DateTime? likedAt;

  const QuoteEntity({
    required this.quote,
    required this.author,
    required this.isLiked,
    required this.quoteKey,
    required this.likedAt,
    required this.isOwnQuote,
  });

  QuoteEntity copyWith({
    String? author,
    String? quote,
    bool? isLiked,
    bool? isOwnQuote,
    DateTime? likedAt,
  }) {
    return QuoteEntity(
      quote: quote ?? this.quote,
      author: author ?? this.author,
      isLiked: isLiked ?? this.isLiked,
      isOwnQuote: isOwnQuote ?? this.isOwnQuote,
      likedAt: likedAt ?? this.likedAt,
      quoteKey: quoteKey,
    );
  }

  factory QuoteEntity.fromModel(QuoteModel model) {
    return QuoteEntity(
      quote: model.quote,
      author: model.author,
      isLiked: model.isLiked,
      isOwnQuote: model.isOwnQuote,
      likedAt: model.likedAt,
      quoteKey: model.quoteKey,
    );
  }
}
