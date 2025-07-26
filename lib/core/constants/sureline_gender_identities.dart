/// Gender identity constants for the Sureline app.
///
/// This file contains gender identity-related constants and configurations
/// for user preferences within the Sureline app. The [SurelineGenderIdentities]
/// class defines available gender identity options for personalization.
///
/// Key Features:
/// - Gender identity model definitions
/// - Inclusive identity options
/// - Personalization settings
/// - User preference management
///
/// Usage:
/// ```dart
/// // Access available gender identities
/// var identities = SurelineGenderIdentities.values;
///
/// // Get identity by title
/// var identity = identities.firstWhere((g) => g.title == 'Female');
/// ```

import 'package:sureline/features/preferenecs/general_settings/gender_identity/data/model/gender_identity_model.dart';

/// Gender identity configuration class.
///
/// This class defines the available gender identity options for
/// user personalization in the Sureline app. It provides a
/// centralized location for gender identity configurations.
///
/// Responsibilities:
/// - Define available gender identity options
/// - Support inclusive identity representation
/// - Enable personalization features
/// - Manage user preference settings
///
/// Note: These options are used for personalizing quote content
/// and user experience based on individual preferences.
class SurelineGenderIdentities {
  /// List of available gender identity options.
  ///
  /// Contains gender identity configurations for user personalization
  /// and content customization. These options are used to tailor
  /// the app experience to individual user preferences.
  ///
  /// Available Options:
  /// - Female: For female-identifying users
  /// - Male: For male-identifying users
  /// - Non-binary: For non-binary users
  /// - Others: For other gender identities
  ///
  /// Usage:
  /// ```dart
  /// // Get all available gender identities
  /// var identities = SurelineGenderIdentities.values;
  ///
  /// // Filter by specific identity
  /// var female = identities.where((g) => g.title == 'Female');
  /// ```
  static final List<GenderIdentityModel> values = [
    const GenderIdentityModel(title: 'Female'),
    const GenderIdentityModel(title: 'Male'),
    const GenderIdentityModel(title: 'Non-binary'),
    const GenderIdentityModel(title: 'Others'),
  ];
}
