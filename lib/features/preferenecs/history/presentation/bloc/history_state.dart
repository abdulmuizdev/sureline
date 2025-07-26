import 'package:sureline/common/domain/entities/collections/history_entity.dart';

/// Abstract base class for all history-related states.
///
/// States represent the different UI states that the history feature
/// can be in, from initial loading to displaying data or error states.
abstract class HistoryState {}

/// Initial state when the history feature is first loaded.
///
/// This state is emitted when the HistoryBloc is first created
/// and no data has been loaded yet. The UI should show a loading
/// indicator or empty state.
class HistoryInitial extends HistoryState {}

/// State when history data is being loaded.
///
/// This state is emitted while the bloc is fetching history
/// records from the data source. The UI should show a loading
/// indicator during this operation.
class HistoryLoading extends HistoryState {}

/// State when history records have been successfully loaded.
///
/// This state is emitted after successfully retrieving history
/// records from the data source. The UI should display the list
/// of history items with appropriate interactions.
///
/// [history] - List of history entities to display
class HistoryLoaded extends HistoryState {
  final List<HistoryEntity> history;

  HistoryLoaded(this.history);
}

/// State when an error occurs during history operations.
///
/// This state is emitted when an error occurs while retrieving
/// or manipulating history data. The UI should display an
/// appropriate error message to the user.
///
/// [message] - Error message describing what went wrong
class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
