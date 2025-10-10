/// Quote data file constants for the Sureline app.
///
/// This file contains constants for quote data file paths used
/// throughout the Sureline app. The [QuotesDataFiles] class defines
/// the available quote data files for different authors and categories.
///
/// Key Features:
/// - Quote data file path definitions
/// - Author-specific data files
/// - Asset file organization
/// - Data loading constants
///
/// Usage:
/// ```dart
/// // Access all quote data files
/// var files = QuotesDataFiles.files;
///
/// // Load specific author data
/// var napoleonHillFile = QuotesDataFiles.files[2];
/// ```

/// Quote data files configuration class.
///
/// This class defines the available quote data files that contain
/// inspirational quotes from various authors. It provides a centralized
/// location for quote data file management and loading.
///
/// Responsibilities:
/// - Define quote data file paths
/// - Organize files by author
/// - Support data loading operations
/// - Enable quote content management
///
/// File Structure:
/// - extras.json: Additional quotes and miscellaneous content
/// - jim_collins.json: Quotes from Jim Collins
/// - napoleon_hill.json: Quotes from Napoleon Hill
/// - peter_drucker.json: Quotes from Peter Drucker
class QuotesDataFiles {
  /// List of quote data file paths.
  ///
  /// Contains the file paths for all quote data files used in the app.
  /// These files are stored in the assets/data directory and contain
  /// JSON-formatted quote data from various authors.
  ///
  /// Available Files:
  /// - extras.json: Additional quotes and miscellaneous content
  /// - jim_collins.json: Quotes from Jim Collins
  /// - napoleon_hill.json: Quotes from Napoleon Hill
  /// - peter_drucker.json: Quotes from Peter Drucker
  ///
  /// Usage:
  /// ```dart
  /// // Get all quote data files
  /// var files = QuotesDataFiles.files;
  ///
  /// // Access specific author file
  /// var napoleonHillFile = files[2]; // napoleon_hill.json
  ///
  /// // Load file content
  /// var content = await rootBundle.loadString(napoleonHillFile);
  /// ```
  static const List<String> files = [
    'assets/data/extras.json',
    'assets/data/jim_collins.json',
    'assets/data/napoleon_hill.json',
    'assets/data/peter_drucker.json',
  ];
  static const List<String> premiumFiles = [
    'assets/data/james_clear.json',
    'assets/data/paulo_coelho.json',
    'assets/data/eckhart_tolle.json',
  ];
}
