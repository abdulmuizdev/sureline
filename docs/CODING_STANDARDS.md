# Sureline Coding Standards

## Overview

This document outlines the coding standards and best practices for the Sureline Flutter application. Following these standards ensures code consistency, maintainability, and adherence to Clean Architecture principles.

## 📝 Naming Conventions

### Files and Directories
- Use `snake_case` for file and directory names
- Use descriptive names that indicate the purpose
- Group related files in appropriate directories

```
✅ Good:
lib/features/collections/presentation/pages/collection_list_page.dart
lib/features/collections/domain/entities/collection_entity.dart
lib/core/utils/date_formatter.dart

❌ Bad:
lib/features/collections/pages/page.dart
lib/features/collections/entity.dart
lib/core/utils/utils.dart
```

### Classes and Types
- Use `PascalCase` for class names, enums, and typedefs
- Use descriptive names that indicate the purpose

```dart
✅ Good:
class CollectionEntity {}
class GetCollectionsUseCase {}
class CollectionsBloc {}

❌ Bad:
class Entity {}
class UseCase {}
class Bloc {}
```

### Variables and Functions
- Use `camelCase` for variables, functions, and methods
- Use descriptive names that indicate the purpose
- Use verbs for functions and boolean variables

```dart
✅ Good:
String userName;
bool isLoading;
List<CollectionEntity> collections;

void getUserData() {}
bool hasValidInput() {}
List<CollectionEntity> getCollections() {}

❌ Bad:
String user;
bool loading;
List<CollectionEntity> list;

void getData() {}
bool valid() {}
List<CollectionEntity> get() {}
```

### Constants
- Use `UPPER_SNAKE_CASE` for constants
- Group related constants in classes

```dart
✅ Good:
class AppConstants {
  static const String API_BASE_URL = 'https://api.sureline.com';
  static const int REQUEST_TIMEOUT = 30;
  static const String DEFAULT_FONT_FAMILY = 'Poppins';
}

❌ Bad:
const String apiUrl = 'https://api.sureline.com';
const int timeout = 30;
```

## 🏗️ Architecture Standards

### Clean Architecture Layers

#### Domain Layer
- Contains business logic and entities
- No dependencies on outer layers
- Use abstract classes for repository interfaces

```dart
// ✅ Good
abstract class CollectionsRepository {
  Future<Either<Failure, List<CollectionEntity>>> getCollections();
  Future<Either<Failure, void>> saveCollection(CollectionEntity collection);
}

class CollectionEntity extends Equatable {
  final int id;
  final String name;
  final DateTime createdAt;

  const CollectionEntity({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, name, createdAt];
}
```

#### Data Layer
- Implements repository interfaces
- Contains data sources and models
- Maps between entities and models

```dart
// ✅ Good
class CollectionsRepositoryImpl implements CollectionsRepository {
  final CollectionsDataSource dataSource;

  CollectionsRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<CollectionEntity>>> getCollections() async {
    final result = await dataSource.getCollections();
    return result.map((models) => models.map((model) => model.toEntity()).toList());
  }
}

class CollectionModel {
  final int id;
  final String name;
  final DateTime createdAt;

  CollectionModel({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  CollectionEntity toEntity() => CollectionEntity(
    id: id,
    name: name,
    createdAt: createdAt,
  );

  factory CollectionModel.fromEntity(CollectionEntity entity) => CollectionModel(
    id: entity.id,
    name: entity.name,
    createdAt: entity.createdAt,
  );
}
```

#### Presentation Layer
- Contains UI components and state management
- Uses Bloc pattern for state management
- Keeps UI logic separate from business logic

```dart
// ✅ Good
class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final GetCollectionsUseCase _getCollectionsUseCase;

  CollectionsBloc(this._getCollectionsUseCase) : super(CollectionsInitial()) {
    on<GetCollections>(_onGetCollections);
  }

  Future<void> _onGetCollections(
    GetCollections event,
    Emitter<CollectionsState> emit,
  ) async {
    emit(CollectionsLoading());
    final result = await _getCollectionsUseCase.execute();
    result.fold(
      (failure) => emit(CollectionsError(failure)),
      (collections) => emit(CollectionsLoaded(collections)),
    );
  }
}
```

## 🎯 State Management Standards

### Bloc Pattern

#### Events
- Use descriptive event names
- Include necessary data in events
- Keep events focused and single-purpose

```dart
// ✅ Good
abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();
}

class GetCollections extends CollectionsEvent {}

class SaveCollection extends CollectionsEvent {
  final CollectionEntity collection;
  const SaveCollection(this.collection);
}

class DeleteCollection extends CollectionsEvent {
  final int collectionId;
  const DeleteCollection(this.collectionId);
}
```

#### States
- Use immutable states with Freezed
- Include all necessary data in states
- Handle all possible states (initial, loading, success, error)

```dart
// ✅ Good
@freezed
class CollectionsState with _$CollectionsState {
  const factory CollectionsState.initial() = _Initial;
  const factory CollectionsState.loading() = _Loading;
  const factory CollectionsState.loaded(List<CollectionEntity> collections) = _Loaded;
  const factory CollectionsState.error(Failure failure) = _Error;
}
```

#### Bloc Implementation
- Keep business logic in use cases, not in Bloc
- Handle errors properly
- Use proper event handling

```dart
// ✅ Good
class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final GetCollectionsUseCase _getCollectionsUseCase;
  final SaveCollectionUseCase _saveCollectionUseCase;

  CollectionsBloc({
    required GetCollectionsUseCase getCollectionsUseCase,
    required SaveCollectionUseCase saveCollectionUseCase,
  })  : _getCollectionsUseCase = getCollectionsUseCase,
        _saveCollectionUseCase = saveCollectionUseCase,
        super(const CollectionsState.initial()) {
    on<GetCollections>(_onGetCollections);
    on<SaveCollection>(_onSaveCollection);
  }

  Future<void> _onGetCollections(
    GetCollections event,
    Emitter<CollectionsState> emit,
  ) async {
    emit(const CollectionsState.loading());
    final result = await _getCollectionsUseCase.execute();
    result.fold(
      (failure) => emit(CollectionsState.error(failure)),
      (collections) => emit(CollectionsState.loaded(collections)),
    );
  }
}
```

## 🔧 Error Handling Standards

### Functional Error Handling with Dartz

```dart
// ✅ Good
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error occurred']) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache error occurred']) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network error occurred']) : super(message);
}

// Use cases return Either<Failure, Success>
class GetCollectionsUseCase {
  final CollectionsRepository repository;

  GetCollectionsUseCase(this.repository);

  Future<Either<Failure, List<CollectionEntity>>> execute() async {
    return repository.getCollections();
  }
}
```

### Error Handling in UI

```dart
// ✅ Good
BlocBuilder<CollectionsBloc, CollectionsState>(
  builder: (context, state) {
    return state.when(
      initial: () => const SizedBox(),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (collections) => CollectionsList(collections: collections),
      error: (failure) => ErrorWidget(failure: failure),
    );
  },
);
```

## 📱 Widget Standards

### Widget Structure
- Keep widgets small and focused
- Use const constructors when possible
- Separate UI logic from business logic

```dart
// ✅ Good
class CollectionListItem extends StatelessWidget {
  final CollectionEntity collection;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CollectionListItem({
    super.key,
    required this.collection,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(collection.name),
      subtitle: Text(collection.createdAt.toString()),
      onTap: onTap,
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
```

### Widget Testing
- Write tests for all public widgets
- Test different states and interactions
- Use meaningful test descriptions

```dart
// ✅ Good
testWidgets('CollectionListItem displays collection name and handles tap', (WidgetTester tester) async {
  // Arrange
  final collection = CollectionEntity(
    id: 1,
    name: 'Test Collection',
    createdAt: DateTime.now(),
  );
  bool tapped = false;

  // Act
  await tester.pumpWidget(
    MaterialApp(
      home: CollectionListItem(
        collection: collection,
        onTap: () => tapped = true,
        onDelete: () {},
      ),
    ),
  );

  // Assert
  expect(find.text('Test Collection'), findsOneWidget);
  expect(tapped, false);

  await tester.tap(find.byType(ListTile));
  expect(tapped, true);
});
```

## 🧪 Testing Standards

### Unit Testing
- Test all business logic
- Use descriptive test names
- Follow Arrange-Act-Assert pattern
- Mock dependencies properly

```dart
// ✅ Good
void main() {
  group('GetCollectionsUseCase', () {
    late GetCollectionsUseCase useCase;
    late MockCollectionsRepository mockRepository;

    setUp(() {
      mockRepository = MockCollectionsRepository();
      useCase = GetCollectionsUseCase(mockRepository);
    });

    test('should return collections when repository call is successful', () async {
      // Arrange
      final collections = [
        CollectionEntity(id: 1, name: 'Test Collection', createdAt: DateTime.now()),
      ];
      when(mockRepository.getCollections())
          .thenAnswer((_) async => Right(collections));

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, Right(collections));
      verify(mockRepository.getCollections()).called(1);
    });

    test('should return failure when repository call fails', () async {
      // Arrange
      final failure = ServerFailure();
      when(mockRepository.getCollections())
          .thenAnswer((_) async => Left(failure));

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, Left(failure));
      verify(mockRepository.getCollections()).called(1);
    });
  });
}
```

### Integration Testing
- Test complete user flows
- Test feature interactions
- Use realistic test data

```dart
// ✅ Good
testWidgets('User can create and view collections', (WidgetTester tester) async {
  // Arrange
  await tester.pumpWidget(const MyApp());

  // Act - Navigate to collections
  await tester.tap(find.byIcon(Icons.collections));
  await tester.pumpAndSettle();

  // Act - Create new collection
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();

  await tester.enterText(find.byType(TextField), 'My New Collection');
  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();

  // Assert
  expect(find.text('My New Collection'), findsOneWidget);
});
```

## 📊 Performance Standards

### Widget Optimization
- Use const constructors when possible
- Implement buildWhen for selective rebuilds
- Use ListView.builder for large lists
- Avoid unnecessary widget rebuilds

```dart
// ✅ Good
BlocBuilder<CollectionsBloc, CollectionsState>(
  buildWhen: (previous, current) =>
    previous.runtimeType != current.runtimeType,
  builder: (context, state) {
    return state.when(
      initial: () => const SizedBox(),
      loading: () => const Center(child: CircularProgressIndicator()),
      loaded: (collections) => ListView.builder(
        itemCount: collections.length,
        itemBuilder: (context, index) => CollectionListItem(
          collection: collections[index],
          onTap: () => context.read<CollectionsBloc>().add(
            CollectionSelected(collections[index]),
          ),
        ),
      ),
      error: (failure) => ErrorWidget(failure: failure),
    );
  },
);
```

### Memory Management
- Cancel subscriptions in dispose methods
- Use lazy loading for large datasets
- Implement proper cleanup in Bloc dispose
- Use weak references where appropriate

```dart
// ✅ Good
class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  StreamSubscription? _subscription;

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
```

## 📝 Documentation Standards

### Code Documentation
- Document all public APIs
- Use clear and concise descriptions
- Include examples for complex methods
- Document parameters and return values

```dart
/// A repository for managing collections of quotes.
///
/// This repository provides methods for creating, reading, updating,
/// and deleting collections. It handles both local and remote data sources.
abstract class CollectionsRepository {
  /// Retrieves all collections for the current user.
  ///
  /// Returns a list of [CollectionEntity] objects, or a [Failure]
  /// if the operation fails.
  Future<Either<Failure, List<CollectionEntity>>> getCollections();

  /// Saves a new collection or updates an existing one.
  ///
  /// [collection] - The collection to save
  /// Returns void on success, or a [Failure] if the operation fails.
  Future<Either<Failure, void>> saveCollection(CollectionEntity collection);
}
```

### README Documentation
- Keep README up to date
- Include setup instructions
- Document key features
- Provide usage examples

## 🔒 Security Standards

### Data Protection
- Encrypt sensitive data in SharedPreferences
- Use secure storage for API keys
- Validate all inputs before processing
- Implement proper error handling without exposing sensitive information

### Network Security
- Use HTTPS for all API calls
- Implement certificate pinning for production
- Validate server responses before processing
- Handle network errors gracefully

## 📈 Code Quality Standards

### Linting
- Use very_good_analysis for comprehensive linting
- Fix all lint warnings before committing
- Use custom lint rules for project-specific standards

### Code Metrics
- Keep cyclomatic complexity low (< 5)
- Limit lines of code per function (< 20)
- Limit parameters per function (< 3)
- Keep classes focused and small

### Code Review
- Review all code changes
- Ensure adherence to standards
- Check for security vulnerabilities
- Verify test coverage

## 🛠️ Development Workflow

### Git Workflow
1. Create feature branch from main
2. Make changes following standards
3. Write tests for new functionality
4. Run linting and tests
5. Create pull request
6. Address review feedback
7. Merge to main

### Commit Messages
- Use conventional commit format
- Write clear, descriptive messages
- Reference issues when applicable

```
feat: add collection management feature
fix: resolve import errors in collections module
docs: update architecture documentation
test: add unit tests for collection use cases
```

---

Following these standards ensures that Sureline maintains high code quality, is easily maintainable, and follows industry best practices for Flutter development.