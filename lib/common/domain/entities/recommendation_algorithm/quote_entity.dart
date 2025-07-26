/// Quote-related domain entities for the recommendation algorithm.
///
/// This file contains the domain entity for handling quote data
/// within the recommendation algorithm system of the Sureline app.
/// The [QuoteEntity] represents a quote with metadata used for
/// recommendation purposes, including user interaction data.
///
/// Key Features:
/// - Immutable quote data structure
/// - Author attribution support
/// - Creation and display timestamp tracking
/// - User interaction tracking (likes)
/// - GlobalKey for UI reference
/// - CopyWith method for immutable updates
///
/// Usage:
/// ```dart
/// final quote = QuoteEntity(
///   id: 1,
///   quoteText: 'Be the change you wish to see in the world.',
///   author: 'Mahatma Gandhi',
///   createdAt: DateTime.now(),
///   shownAt: DateTime.now(),
///   quoteKey: GlobalKey(),
///   isLiked: true,
/// );
/// ```

import 'package:flutter/material.dart';

/// Entity representing a quote for recommendation algorithm purposes.
///
/// This entity is used by the recommendation algorithm to track quotes
/// and their user interactions. It includes metadata about when the quote
/// was created, when it was shown to the user, and how the user interacted
/// with it (liked/disliked).
///
/// Properties:
/// - [id]: Unique identifier for the quote
/// - [quoteText]: The actual quote text content
/// - [author]: The author of the quote (optional)
/// - [createdAt]: When the quote was created in the system
/// - [shownAt]: When the quote was last shown to the user (optional)
/// - [quoteKey]: GlobalKey for UI reference and widget identification
/// - [isLiked]: Whether the user liked this quote
///
/// The entity is immutable and provides a copyWith method for creating
/// modified instances.
class QuoteEntity {
  /// Unique identifier for the quote.
  ///
  /// Used to distinguish between different quotes in the system.
  final int id;

  /// The actual quote text content.
  ///
  /// Contains the inspirational or motivational quote text.
  final String quoteText;

  /// The author of the quote.
  ///
  /// Optional field that may be null for anonymous quotes.
  final String? author;

  /// When the quote was created in the system.
  ///
  /// Timestamp when this quote was added to the database.
  final DateTime createdAt;

  /// When the quote was last shown to the user.
  ///
  /// Optional timestamp tracking when the user last saw this quote.
  /// Null if the quote has never been shown.
  final DateTime? shownAt;

  /// GlobalKey for UI reference and widget identification.
  ///
  /// Used to identify and reference the quote widget in the UI.
  final GlobalKey quoteKey;

  /// Whether the user liked this quote.
  ///
  /// True if the user has indicated they like this quote,
  /// false if they disliked it or haven't interacted.
  final bool isLiked;

  /// Whether the quote is premium.
  final bool isPremium;

  /// Creates a [QuoteEntity] instance.
  ///
  /// [id], [quoteText], [createdAt], [quoteKey], and [isLiked] are required.
  /// [author] and [shownAt] are optional.
  ///
  /// [id]: Unique identifier for the quote
  /// [quoteText]: The quote text content
  /// [author]: The author of the quote (optional)
  /// [createdAt]: When the quote was created
  /// [shownAt]: When the quote was last shown (optional)
  /// [quoteKey]: GlobalKey for UI reference
  /// [isLiked]: Whether the user liked this quote
  /// [isPremium]: Whether the quote is premium
  QuoteEntity({
    required this.id,
    required this.quoteText,
    this.author,
    required this.createdAt,
    this.shownAt,
    required this.quoteKey,
    required this.isLiked,
    this.isPremium = false,
  });

  /// Creates a copy of this entity with the given fields replaced by new values.
  ///
  /// This method allows for immutable updates by creating a new instance
  /// with only the specified fields changed.
  ///
  /// All parameters are optional. If not provided, the current value is used.
  /// Returns: A new [QuoteEntity] instance with updated values
  QuoteEntity copyWith({
    int? id,
    String? quoteText,
    String? author,
    DateTime? createdAt,
    DateTime? shownAt,
    GlobalKey? quoteKey,
    bool? isLiked,
    bool? isPremium,
  }) {
    return QuoteEntity(
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
}
