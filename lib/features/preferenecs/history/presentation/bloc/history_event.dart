import 'package:sureline/common/domain/entities/collections/history_entity.dart';

/// Abstract base class for all history-related events.
///
/// Events are dispatched to the HistoryBloc to trigger state changes
/// and business logic operations in the history feature. This feature
/// allows users to view their browsing history and manage favourite
/// status of previously viewed quotes.
abstract class HistoryEvent {}

/// Event to retrieve all history records from the data source.
///
/// This event triggers the loading of all user's browsing history,
/// typically called when the history screen is first opened.
/// The bloc will emit HistoryLoaded state with the loaded history.
class GetHistory extends HistoryEvent {}

/// Event triggered when user toggles the favourite status of a history item.
///
/// This event is dispatched when the user taps the favourite button
/// on a history item. The bloc will update the favourite status
/// and refresh the history list to reflect the changes.
///
/// [entity] - The history entity to be favourited/unfavourited
/// [isLiked] - The new favourite status (true for favourited, false for unfavourited)
class OnLikePressed extends HistoryEvent {
  final HistoryEntity entity;
  final bool isLiked;
  OnLikePressed(this.entity, this.isLiked);
}
