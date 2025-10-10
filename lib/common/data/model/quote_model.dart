import 'package:flutter/material.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/common/domain/entities/recommendation_algorithm/quote_entity.dart';

class QuoteModel extends QuoteEntity {
  QuoteModel({
    required super.id,
    required super.quoteText,
    super.author,
    required super.createdAt,
    super.shownAt,
    required super.quoteKey,
    required super.isLiked,
    this.isPremium = false,
  }) : super(isPremium: isPremium);

  final bool isPremium;

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return QuoteModel(
      id: json['id'] as int? ?? 0,
      quoteText: json['q_text'] as String,
      author: json['author'] as String?,
      createdAt: DateTime.now(),
      shownAt: null,
      quoteKey: GlobalKey(),
      isLiked: false,
      isPremium: json['isPremium'] as bool? ?? false,
    );
  }

  factory QuoteModel.fromQuote(Quote quote) {
    return QuoteModel(
      id: quote.id,
      quoteText: quote.quoteText,
      author: quote.author,
      createdAt: quote.createdAt,
      shownAt: quote.shownAt,
      quoteKey: GlobalKey(),
      isLiked: false,
      isPremium: quote.isPremium,
    );
  }
  factory QuoteModel.fromEntity(QuoteEntity entity) {
    return QuoteModel(
      id: entity.id,
      quoteText: entity.quoteText,
      author: entity.author,
      createdAt: entity.createdAt,
      shownAt: entity.shownAt,
      quoteKey: entity.quoteKey,
      isLiked: entity.isLiked,
      isPremium: entity.isPremium,
    );
  }
  QuoteModel copyWith({
    int? id,
    String? quoteText,
    String? author,
    DateTime? createdAt,
    DateTime? shownAt,
    GlobalKey? quoteKey,
    bool? isLiked,
    bool? isPremium,
  }) {
    return QuoteModel(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      shownAt: shownAt ?? this.shownAt,
      quoteKey: quoteKey ?? this.quoteKey,
      isLiked: isLiked ?? this.isLiked,
      isPremium: isPremium ?? this.isPremium,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quoteText': quoteText,
      'author': author,
      'createdAt': createdAt?.toIso8601String(),
      'shownAt': shownAt?.toIso8601String(),
      'isLiked': isLiked,
      'isPremium': isPremium,
    };
  }
}
