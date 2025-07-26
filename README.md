# Sureline - Positive Energy for Founders

[![Flutter](https://img.shields.io/badge/Flutter-3.7.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.7.0-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> A motivational and knowledge-based quote app that delivers micro-content in 1–2 second readable bites via widgets and notifications.

## 📱 Overview

Sureline is an iOS-only Flutter application that combines affirmations, wisdom, and inspiration from renowned authors to deliver micro-content through widgets and notifications. The experience is designed to be visually dynamic, fluid, and precise—on par with top-tier, million-dollar applications.

### Core Features

- **Micro-Content Delivery**: 1-2 second readable quote bites
- **Widget Integration**: Home screen widgets for quick inspiration
- **Notification System**: Scheduled motivational notifications
- **Collection Management**: Organize and save favorite quotes
- **Theme Customization**: Dynamic theme selection with real-time preview
- **Voice Integration**: Text-to-speech for quote narration
- **Search & Discovery**: Find quotes by author, topic, or content
- **Streak Tracking**: Gamified engagement with daily streaks

## 🏗️ Architecture

Sureline follows **Clean Architecture** principles with a **Feature-First** organization:

```
lib/
├── core/                          # Shared/common code
│   ├── app/                       # App configuration
│   ├── constants/                 # App constants
│   ├── db/                        # Database configuration
│   ├── di/                        # Dependency injection
│   ├── error/                     # Error handling
│   ├── network/                   # Network utilities
│   ├── theme/                     # App theming
│   └── utils/                     # Utility functions
├── common/                        # Shared domain entities
│   ├── data/                      # Shared data models
│   ├── domain/                    # Shared domain entities
│   └── presentation/              # Shared UI components
├── features/                      # Feature modules
│   ├── home/                      # Home screen
│   ├── onboarding/                # User onboarding
│   ├── collections/               # Quote collections
│   ├── favourites/                # Favorites management
│   ├── search/                    # Quote search
│   ├── notifications_settings/    # Notification preferences
│   ├── theme_selection/           # Theme customization
│   ├── unsplash_screen/          # Background image selection
│   └── ...                       # Other features
└── main.dart                      # App entry point
```

### Technology Stack

- **Framework**: Flutter 3.7.0
- **State Management**: flutter_bloc
- **Dependency Injection**: GetIt
- **Database**: Drift (SQLite)
- **Network**: Dio
- **Error Handling**: Dartz (Either)
- **Routing**: GoRouter
- **Testing**: Mockito, flutter_test

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.7.0 or higher
- Dart SDK 3.7.0 or higher
- Xcode 14.0+ (for iOS development)
- CocoaPods

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/sureline.git
   cd sureline
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Install iOS dependencies**
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Development Setup

1. **Code Generation**
   ```bash
   # Generate Drift database code
   dart run build_runner build

   # Generate mocks for testing
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **Linting and Analysis**
   ```bash
   # Run static analysis
   flutter analyze

   # Run code metrics
   dart run dart_code_metrics:metrics analyze lib
   ```

3. **Testing**
   ```bash
   # Run unit tests
   flutter test

   # Run integration tests
   flutter test integration_test/
   ```

## 📚 Documentation

### Architecture Documentation

- [Clean Architecture Guide](docs/ARCHITECTURE.md)
- [State Management with Bloc](docs/BLOC_PATTERN.md)
- [Database Schema](docs/DATABASE.md)
- [API Documentation](docs/API.md)

### Development Guidelines

- [Coding Standards](docs/CODING_STANDARDS.md)
- [Testing Strategy](docs/TESTING.md)
- [Performance Guidelines](docs/PERFORMANCE.md)

### Feature Documentation

- [Widget Implementation](docs/WIDGETS.md)
- [Notification System](docs/NOTIFICATIONS.md)
- [Theme System](docs/THEMES.md)

## 🧪 Testing

### Test Structure

```
test/
├── unit/                          # Unit tests
├── widget/                        # Widget tests
├── integration/                   # Integration tests
└── helpers/                       # Test utilities
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/unit/feature_test.dart

# Run with coverage
flutter test --coverage
```

## 📦 Build & Deploy

### iOS Build

```bash
# Build for development
flutter build ios --debug

# Build for release
flutter build ios --release

# Build for App Store
flutter build ios --release --no-codesign
```

### Code Signing

1. Configure certificates in Xcode
2. Update bundle identifier in `ios/Runner.xcodeproj`
3. Configure provisioning profiles

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
# API Configuration
API_BASE_URL=https://api.sureline.com
API_KEY=your_api_key

# Feature Flags
ENABLE_NOTIFICATIONS=true
ENABLE_WIDGETS=true
```

### Secrets Configuration

The app uses a secrets file for sensitive configuration like API keys. Follow these steps to set up:

1. **Copy the template file:**
   ```bash
   # Option 1: Use the setup script (recommended)
   ./scripts/setup_secrets.sh

   # Option 2: Manual copy
   cp lib/core/constants/secrets.template.dart lib/core/constants/secrets.dart
   ```

2. **Update the secrets file** with your actual API keys:
   ```dart
   // In lib/core/constants/secrets.dart
   static const String flagSmithApiKey = 'your_actual_flagsmith_key';
   static const String superwallApiKey = 'your_actual_superwall_key';
   static const String cannyPrivateKey = 'your_actual_canny_private_key';
   static const String cannyBoardToken = 'your_actual_canny_board_token';
   static const String facebookAppId = 'your_actual_facebook_app_id';
   static const String facebookClientToken = 'your_actual_facebook_client_token';
   static const String tiktokClientKey = 'your_actual_tiktok_client_key';
   static const String revenueCatApiKey = 'your_actual_revenuecat_api_key';
   static const String defaultUserEmail = 'your_actual_default_user_email';
   ```

3. **For production builds**, use environment variables:
   ```bash
   flutter build ios --dart-define=FLAGSMITH_API_KEY=your_key --dart-define=SUPERWALL_API_KEY=your_key --dart-define=CANNY_PRIVATE_KEY=your_key --dart-define=CANNY_BOARD_TOKEN=your_key --dart-define=FACEBOOK_APP_ID=your_key --dart-define=FACEBOOK_CLIENT_TOKEN=your_key --dart-define=TIKTOK_CLIENT_KEY=your_key --dart-define=REVENUECAT_API_KEY=your_key --dart-define=DEFAULT_USER_EMAIL=your_key
   ```

**Important:** The `secrets.dart` file is ignored by git to prevent committing sensitive data. Always use the template file for reference.

### Feature Flags

Sureline uses Flagsmith for feature flag management. Configure in `lib/features/remote_config/`.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Workflow

1. **Create Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Follow Clean Architecture**
   - Implement domain layer first
   - Add data layer implementation
   - Create presentation layer
   - Write tests for each layer

3. **Code Quality**
   - Run `flutter analyze` before committing
   - Ensure all tests pass
   - Follow the established naming conventions

4. **Documentation**
   - Update relevant documentation
   - Add inline comments for complex logic
   - Update API documentation if needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- The open-source community for the excellent packages

## 📞 Support

For support, email sureline.app@abdulmuiz.dev

---

**Made with ❤️ for founders who need positive energy**
