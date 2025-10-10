import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';

/// Abstract base class for all own quotes events.
///
/// Events are dispatched to the OwnQuotesBloc to trigger state changes
/// and business logic operations in the own quotes feature. This feature
/// allows users to create, manage, and interact with their custom quotes.
abstract class OwnQuotesEvent {
  const OwnQuotesEvent();
}

/// Event to retrieve all user's own quotes.
///
/// This event triggers the loading of all custom quotes created by
/// the user. The bloc will emit GotOwnQuotes state with the loaded quotes.
class GetOwnQuotes extends OwnQuotesEvent {}

/// Event triggered when user requests to delete an own quote.
///
/// This event is dispatched when the user confirms deletion of a custom
/// quote. The bloc will remove the quote and refresh the list to reflect
/// the changes.
///
/// [entity] - The own quote entity to be deleted
class OnDeletePressed extends OwnQuotesEvent {
  final OwnQuoteEntity entity;
  const OnDeletePressed(this.entity);
}

/// Event to save a new own quote.
///
/// This event is dispatched when the user creates a new custom quote.
/// The bloc will save the quote to storage and refresh the list to
/// include the new quote.
///
/// [entity] - The own quote entity to be saved
class SaveOwnQuote extends OwnQuotesEvent {
  final OwnQuoteEntity entity;
  const SaveOwnQuote(this.entity);
}

/// Event triggered when user toggles the favourite status of an own quote.
///
/// This event is dispatched when the user taps the favourite button
/// on an own quote. The bloc will update the favourite status and
/// refresh the list to reflect the changes.
///
/// [entity] - The own quote entity to be favourited/unfavourited
/// [isLiked] - The new favourite status (true for favourited, false for unfavourited)
class OnLikePressed extends OwnQuotesEvent {
  final OwnQuoteEntity entity;
  final bool isLiked;
  const OnLikePressed(this.entity, this.isLiked);
}
