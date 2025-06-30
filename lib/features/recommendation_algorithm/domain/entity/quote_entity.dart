import 'package:flutter/material.dart';

class QuoteEntity {
  final int id;
  final String quoteText;
  final String? author;
  final DateTime createdAt;
  final DateTime? shownAt;
  final GlobalKey quoteKey;
  final bool isLiked;

  QuoteEntity({
    required this.id,
    required this.quoteText,
    this.author,
    required this.createdAt,
    this.shownAt,
    required this.quoteKey,
    required this.isLiked,
  });
  QuoteEntity copyWith({
    int? id,
    String? quoteText,
    String? author,
    DateTime? createdAt,
    DateTime? shownAt,
    GlobalKey? quoteKey,
    bool? isLiked,
  }) {
    return QuoteEntity(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      shownAt: shownAt ?? this.shownAt,
      quoteKey: quoteKey ?? this.quoteKey,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
