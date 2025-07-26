# Sureline Architecture Guide

## Overview

Sureline follows **Clean Architecture** principles with a **Feature-First** organization. This document outlines the architectural decisions, patterns, and guidelines used throughout the application.

## 🏗️ Clean Architecture Layers

### 1. Presentation Layer
The outermost layer responsible for UI and user interactions.

**Components:**
- **Pages/Screens**: Full-screen UI components
- **Widgets**: Reusable UI components
- **Blocs**: State management using flutter_bloc
- **Events**: User actions and system events
- **States**: UI state representations

**Location:** `lib/features/{feature}/presentation/`

### 2. Domain Layer
The business logic layer that contains the core application rules.

**Components:**
- **Entities**: Core business objects
- **Use Cases**: Business logic implementation
- **Repository Interfaces**: Data access contracts
- **Failures**: Domain-specific error types

**Location:** `lib/features/{feature}/domain/` and `lib/common/domain/`

### 3. Data Layer
The data access layer that implements repository interfaces.

**Components:**
- **Repository Implementations**: Data access logic
- **Data Sources**: Remote and local data providers
- **Models**: Data transfer objects (DTOs)
- **Mappers**: Entity-model conversions

**Location:** `lib/features/{feature}/data/` and `lib/common/data/`

## 📁 Feature-First Organization

Each feature is self-contained with its own implementation of all layers:

```
lib/features/collections/
├── data/
│   ├── datasources/
│   │   └── collections_data_source.dart
│   ├── models/
│   │   └── collection_model.dart
│   └── repositories/
│       └── collections_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── collection_entity.dart
│   ├── repositories/
│   │   └── collections_repository.dart
│   └── usecases/
│       ├── get_collections_use_case.dart
│       └── save_collection_use_case.dart
└── presentation/
    ├── bloc/
    │   ├── collections_bloc.dart
    │   ├── collections_event.dart
    │   └── collections_state.dart
    ├── pages/
    │   └── collection_list_page.dart
    └── widgets/
        └── collection_list_item.dart
```

## 🔄 Dependency Flow

### Dependency Rule
Dependencies always point inward:
- Presentation → Domain
- Data → Domain
- Domain has no dependencies on outer layers

### Dependency Injection
Using GetIt for service locator pattern:

```dart
// Registration
locator.registerFactory<CollectionsRepository>(
  () => CollectionsRepositoryImpl(locator()),
);

// Usage
final repository = locator<CollectionsRepository>();
```

## 🎯 State Management with Bloc

### Bloc Pattern Implementation

```dart
// Event
abstract class CollectionsEvent extends Equatable {
  const CollectionsEvent();
}

class GetCollections extends CollectionsEvent {}

// State
abstract class CollectionsState extends Equatable {
  const CollectionsState();
}

class CollectionsInitial extends CollectionsState {}
class CollectionsLoading extends CollectionsState {}
class CollectionsLoaded extends CollectionsState {
  final List<CollectionEntity> collections;
  const CollectionsLoaded(this.collections);
}

// Bloc
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

## 🗄️ Database Architecture

### Drift Database Setup

```dart
@DriftDatabase(tables: [CollectionsTable, Favourites, Quotes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 17;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      await m.createAll();
    },
  );
}
```

### Table Definitions

```dart
class CollectionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
}
```

## 🔧 Error Handling

### Functional Error Handling with Dartz

```dart
// Failure classes
abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server error']) : super(message);
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

## 🌐 Network Layer

### Dio Configuration

```dart
class DioClient {
  static Dio getInstance() {
    final dio = Dio();

    dio.options.baseUrl = 'https://api.sureline.com';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }
}
```

## 🧪 Testing Strategy

### Unit Testing

```dart
class MockCollectionsRepository extends Mock implements CollectionsRepository {}

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
      final collections = [CollectionEntity(id: 1, name: 'Test')];
      when(mockRepository.getCollections())
          .thenAnswer((_) async => Right(collections));

      // Act
      final result = await useCase.execute();

      // Assert
      expect(result, Right(collections));
      verify(mockRepository.getCollections()).called(1);
    });
  });
}
```

### Widget Testing

```dart
testWidgets('should display collections list', (WidgetTester tester) async {
  // Arrange
  final collections = [CollectionEntity(id: 1, name: 'Test Collection')];

  // Act
  await tester.pumpWidget(
    BlocProvider(
      create: (context) => CollectionsBloc(mockUseCase)
        ..add(GetCollections()),
      child: MaterialApp(
        home: CollectionsPage(),
      ),
    ),
  );

  // Assert
  expect(find.text('Test Collection'), findsOneWidget);
});
```

## 📊 Performance Considerations

### Widget Optimization

1. **Use const constructors** when possible
2. **Implement buildWhen** in BlocBuilder for selective rebuilds
3. **Use ListView.builder** for large lists
4. **Avoid unnecessary widget rebuilds**

### Memory Management

1. **Cancel subscriptions** in dispose methods
2. **Use lazy loading** for large datasets
3. **Implement proper cleanup** in Bloc dispose
4. **Use weak references** where appropriate

## 🔒 Security

### Data Protection

1. **Encrypt sensitive data** in SharedPreferences
2. **Use secure storage** for API keys
3. **Validate all inputs** before processing
4. **Implement proper error handling** without exposing sensitive information

### Network Security

1. **Use HTTPS** for all API calls
2. **Implement certificate pinning** for production
3. **Validate server responses** before processing
4. **Handle network errors** gracefully

## 📈 Scalability

### Code Organization

1. **Feature isolation**: Each feature is self-contained
2. **Shared components**: Common functionality in core/
3. **Dependency management**: Clear dependency boundaries
4. **Testing strategy**: Comprehensive test coverage

### Performance Optimization

1. **Lazy loading**: Load data only when needed
2. **Caching strategy**: Implement proper caching
3. **Background processing**: Use isolates for heavy operations
4. **Memory management**: Proper resource cleanup

## 🛠️ Development Guidelines

### Code Standards

1. **Follow naming conventions** strictly
2. **Use meaningful variable names**
3. **Keep functions small** (< 20 lines)
4. **Document public APIs**
5. **Write tests for all business logic**

### Architecture Principles

1. **Single Responsibility**: Each class has one reason to change
2. **Open/Closed**: Open for extension, closed for modification
3. **Dependency Inversion**: Depend on abstractions, not concretions
4. **Interface Segregation**: Keep interfaces focused
5. **Liskov Substitution**: Subtypes are substitutable

## 📚 Resources

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Bloc Documentation](https://bloclibrary.dev/)
- [Drift Database Documentation](https://drift.simonbinder.eu/)
- [Dartz Functional Programming](https://pub.dev/packages/dartz)

---

This architecture ensures that Sureline is maintainable, testable, and scalable while following industry best practices for Flutter development.