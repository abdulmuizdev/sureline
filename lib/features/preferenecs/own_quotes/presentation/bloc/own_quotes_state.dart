import 'package:sureline/common/domain/entities/collections/own_quote_entity.dart';

/// Abstract base class for all own quotes states.
///
/// States represent the different UI states that the own quotes feature
/// can be in, from initial loading to displaying data or indicating
/// successful save operations.
abstract class OwnQuotesState {
  const OwnQuotesState();
}

/// Initial state when the own quotes feature is first loaded.
///
/// This state is emitted when the OwnQuotesBloc is first created
/// and no data has been loaded yet. The UI should show a loading
/// indicator or empty state.
class Initial extends OwnQuotesState {}

/// State when own quotes have been successfully loaded.
///
/// This state is emitted after successfully retrieving own quotes
/// from the data source. The UI should display the list of own
/// quotes with appropriate interactions.
///
/// [ownQuotes] - List of own quote entities to display (null if empty)
class GotOwnQuotes extends OwnQuotesState {
  final List<OwnQuoteEntity>? ownQuotes;
  const GotOwnQuotes(this.ownQuotes);
}

/// State when a new own quote has been successfully saved.
///
/// This state is emitted after successfully saving a new own quote
/// to storage. The UI should update the list to include the new quote
/// and show a success indicator.
///
/// [ownQuotes] - Updated list of own quote entities including the new quote
class SavedOwnQuote extends OwnQuotesState {
  final List<OwnQuoteEntity> ownQuotes;
  const SavedOwnQuote(this.ownQuotes);
}
