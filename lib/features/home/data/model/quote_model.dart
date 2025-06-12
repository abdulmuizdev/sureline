import 'package:flutter/cupertino.dart';
import 'package:sureline/features/home/domain/entity/quote_entity.dart';

class QuoteModel extends QuoteEntity {
  QuoteModel({
    required super.quote,
    required super.author,
    required super.isLiked,
    required super.isOwnQuote,
    required super.quoteKey,
    required super.likedAt,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      quote: json['q_text'],
      author: json['author'],
      isLiked: json['isLiked'] ?? false,
      isOwnQuote: json['isOwnQuote'] ?? false,
      likedAt:
          (json['likedAt'] != null) ? DateTime.tryParse(json['likedAt']) : null,
      quoteKey: GlobalKey(),
    );
  }

  @override
  QuoteModel copyWith({
    String? author,
    String? quote,
    bool? isLiked,
    bool? isOwnQuote,
    DateTime? likedAt,
  }) {
    return QuoteModel(
      quote: quote ?? this.quote,
      author: author ?? this.author,
      isLiked: isLiked ?? this.isLiked,
      isOwnQuote: isOwnQuote ?? this.isOwnQuote,
      likedAt: likedAt ?? this.likedAt,
      quoteKey: quoteKey,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'q_text': quote,
      'author': author,
      'isLiked': isLiked,
      'isOwnQuote': isOwnQuote,
      'likedAt': likedAt?.toIso8601String(),
    };
  }
}
