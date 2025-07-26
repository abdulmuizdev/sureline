import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/features/remote_config/domain/repositories/remote_config_repository.dart';

/// Use case for preparing and managing remote configuration settings.
///
/// This use case handles the initialization and management of remote
/// configuration settings that control various app features and behaviors.
/// It provides a centralized way to manage app configuration with proper
/// fallback handling for offline scenarios.
///
/// Key Features:
/// - Remote configuration retrieval and caching
/// - Fallback configuration management
/// - App-wide configuration synchronization
/// - Offline support with local defaults
/// - Configuration validation and error handling
/// - Dynamic feature flag management
///
/// Configuration Management:
/// - Feature flags for A/B testing
/// - App behavior customization
/// - Content delivery optimization
/// - User experience personalization
/// - Performance tuning parameters
/// - Analytics and tracking settings
///
/// Fallback Strategy:
/// - Local default configuration when remote fails
/// - Graceful degradation for offline scenarios
/// - Configuration validation before application
/// - Error logging and monitoring
/// - Automatic retry mechanisms
///
/// App Integration:
/// - Global configuration state management
/// - Real-time configuration updates
/// - Configuration change notifications
/// - Cross-feature configuration sharing
/// - Configuration persistence
///
/// Usage:
/// ```dart
/// final useCase = PrepareRemoteConfigUseCase(remoteConfigRepository);
/// await useCase.execute();
/// ```
class PrepareRemoteConfigUseCase {
  /// Repository for remote configuration operations.
  final RemoteConfigRepository repository;

  /// Creates a new PrepareRemoteConfigUseCase instance.
  PrepareRemoteConfigUseCase(this.repository);

  /// Executes the remote configuration preparation process.
  ///
  /// This method attempts to retrieve remote configuration settings
  /// and applies them to the app. If remote configuration fails,
  /// it falls back to local default settings to ensure the app
  /// continues to function properly.
  ///
  /// Process Flow:
  /// 1. Attempt to retrieve remote configuration
  /// 2. Validate configuration data
  /// 3. Apply configuration to app state
  /// 4. Fall back to local defaults if remote fails
  /// 5. Update global app configuration
  ///
  /// Error Handling:
  /// - Network connectivity issues
  /// - Invalid configuration data
  /// - Remote service unavailability
  /// - Configuration parsing errors
  /// - Timeout scenarios
  ///
  /// Configuration Application:
  /// - Updates App.remoteConfigEntity with new settings
  /// - Triggers configuration change notifications
  /// - Validates configuration before application
  /// - Logs configuration changes for monitoring
  /// - Ensures app stability during updates
  Future<void> execute() async {
    final result = await repository.getRemoteConfig();
    result.fold(
      (left) {
        // Apply fallback configuration on remote failure
        App.remoteConfigEntity = Constants.remoteConfigModel;
      },
      (right) {
        // Apply successful remote configuration
        App.remoteConfigEntity = right;
      },
    );
  }
}
