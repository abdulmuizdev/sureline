// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CollectionsTableTable extends CollectionsTable
    with TableInfo<$CollectionsTableTable, CollectionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionsTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $CollectionsTableTable createAlias(String alias) {
    return $CollectionsTableTable(attachedDatabase, alias);
  }
}

class CollectionsTableData extends DataClass
    implements Insertable<CollectionsTableData> {
  final int id;
  final String name;
  final String createdAt;
  const CollectionsTableData({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  CollectionsTableCompanion toCompanion(bool nullToAbsent) {
    return CollectionsTableCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory CollectionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  CollectionsTableData copyWith({int? id, String? name, String? createdAt}) =>
      CollectionsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  CollectionsTableData copyWithCompanion(CollectionsTableCompanion data) {
    return CollectionsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class CollectionsTableCompanion extends UpdateCompanion<CollectionsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> createdAt;
  const CollectionsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CollectionsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String createdAt,
  }) : name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<CollectionsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CollectionsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? createdAt,
  }) {
    return CollectionsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $QuotesTable extends Quotes with TableInfo<$QuotesTable, Quote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _quoteTextMeta = const VerificationMeta(
    'quoteText',
  );
  @override
  late final GeneratedColumn<String> quoteText = GeneratedColumn<String>(
    'quote_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _shownAtMeta = const VerificationMeta(
    'shownAt',
  );
  @override
  late final GeneratedColumn<DateTime> shownAt = GeneratedColumn<DateTime>(
    'shown_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    quoteText,
    author,
    createdAt,
    shownAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Quote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quote_text')) {
      context.handle(
        _quoteTextMeta,
        quoteText.isAcceptableOrUnknown(data['quote_text']!, _quoteTextMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteTextMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('shown_at')) {
      context.handle(
        _shownAtMeta,
        shownAt.isAcceptableOrUnknown(data['shown_at']!, _shownAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Quote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Quote(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      quoteText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}quote_text'],
          )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      shownAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}shown_at'],
      ),
    );
  }

  @override
  $QuotesTable createAlias(String alias) {
    return $QuotesTable(attachedDatabase, alias);
  }
}

class Quote extends DataClass implements Insertable<Quote> {
  final int id;
  final String quoteText;
  final String? author;
  final DateTime createdAt;
  final DateTime? shownAt;
  const Quote({
    required this.id,
    required this.quoteText,
    this.author,
    required this.createdAt,
    this.shownAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quote_text'] = Variable<String>(quoteText);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || shownAt != null) {
      map['shown_at'] = Variable<DateTime>(shownAt);
    }
    return map;
  }

  QuotesCompanion toCompanion(bool nullToAbsent) {
    return QuotesCompanion(
      id: Value(id),
      quoteText: Value(quoteText),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      createdAt: Value(createdAt),
      shownAt:
          shownAt == null && nullToAbsent
              ? const Value.absent()
              : Value(shownAt),
    );
  }

  factory Quote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Quote(
      id: serializer.fromJson<int>(json['id']),
      quoteText: serializer.fromJson<String>(json['quoteText']),
      author: serializer.fromJson<String?>(json['author']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      shownAt: serializer.fromJson<DateTime?>(json['shownAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quoteText': serializer.toJson<String>(quoteText),
      'author': serializer.toJson<String?>(author),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'shownAt': serializer.toJson<DateTime?>(shownAt),
    };
  }

  Quote copyWith({
    int? id,
    String? quoteText,
    Value<String?> author = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> shownAt = const Value.absent(),
  }) => Quote(
    id: id ?? this.id,
    quoteText: quoteText ?? this.quoteText,
    author: author.present ? author.value : this.author,
    createdAt: createdAt ?? this.createdAt,
    shownAt: shownAt.present ? shownAt.value : this.shownAt,
  );
  Quote copyWithCompanion(QuotesCompanion data) {
    return Quote(
      id: data.id.present ? data.id.value : this.id,
      quoteText: data.quoteText.present ? data.quoteText.value : this.quoteText,
      author: data.author.present ? data.author.value : this.author,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      shownAt: data.shownAt.present ? data.shownAt.value : this.shownAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Quote(')
          ..write('id: $id, ')
          ..write('quoteText: $quoteText, ')
          ..write('author: $author, ')
          ..write('createdAt: $createdAt, ')
          ..write('shownAt: $shownAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, quoteText, author, createdAt, shownAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quote &&
          other.id == this.id &&
          other.quoteText == this.quoteText &&
          other.author == this.author &&
          other.createdAt == this.createdAt &&
          other.shownAt == this.shownAt);
}

class QuotesCompanion extends UpdateCompanion<Quote> {
  final Value<int> id;
  final Value<String> quoteText;
  final Value<String?> author;
  final Value<DateTime> createdAt;
  final Value<DateTime?> shownAt;
  const QuotesCompanion({
    this.id = const Value.absent(),
    this.quoteText = const Value.absent(),
    this.author = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.shownAt = const Value.absent(),
  });
  QuotesCompanion.insert({
    this.id = const Value.absent(),
    required String quoteText,
    this.author = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.shownAt = const Value.absent(),
  }) : quoteText = Value(quoteText);
  static Insertable<Quote> custom({
    Expression<int>? id,
    Expression<String>? quoteText,
    Expression<String>? author,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? shownAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteText != null) 'quote_text': quoteText,
      if (author != null) 'author': author,
      if (createdAt != null) 'created_at': createdAt,
      if (shownAt != null) 'shown_at': shownAt,
    });
  }

  QuotesCompanion copyWith({
    Value<int>? id,
    Value<String>? quoteText,
    Value<String?>? author,
    Value<DateTime>? createdAt,
    Value<DateTime?>? shownAt,
  }) {
    return QuotesCompanion(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      shownAt: shownAt ?? this.shownAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quoteText.present) {
      map['quote_text'] = Variable<String>(quoteText.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (shownAt.present) {
      map['shown_at'] = Variable<DateTime>(shownAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuotesCompanion(')
          ..write('id: $id, ')
          ..write('quoteText: $quoteText, ')
          ..write('author: $author, ')
          ..write('createdAt: $createdAt, ')
          ..write('shownAt: $shownAt')
          ..write(')'))
        .toString();
  }
}

class $FavouritesTable extends Favourites
    with TableInfo<$FavouritesTable, Favourite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavouritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _quoteMeta = const VerificationMeta('quote');
  @override
  late final GeneratedColumn<String> quote = GeneratedColumn<String>(
    'quote',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<int> quoteId = GeneratedColumn<int>(
    'quote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES Quotes(id)',
  );
  static const VerificationMeta _ownQuoteIdMeta = const VerificationMeta(
    'ownQuoteId',
  );
  @override
  late final GeneratedColumn<int> ownQuoteId = GeneratedColumn<int>(
    'own_quote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES OwnQuotesTable(id)',
  );
  static const VerificationMeta _historyIdMeta = const VerificationMeta(
    'historyId',
  );
  @override
  late final GeneratedColumn<int> historyId = GeneratedColumn<int>(
    'history_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES Quotes(id)',
  );
  static const VerificationMeta _searchIdMeta = const VerificationMeta(
    'searchId',
  );
  @override
  late final GeneratedColumn<int> searchId = GeneratedColumn<int>(
    'search_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES Quotes(id)',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    quote,
    quoteId,
    ownQuoteId,
    historyId,
    searchId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favourites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favourite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quote')) {
      context.handle(
        _quoteMeta,
        quote.isAcceptableOrUnknown(data['quote']!, _quoteMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteMeta);
    }
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    }
    if (data.containsKey('own_quote_id')) {
      context.handle(
        _ownQuoteIdMeta,
        ownQuoteId.isAcceptableOrUnknown(
          data['own_quote_id']!,
          _ownQuoteIdMeta,
        ),
      );
    }
    if (data.containsKey('history_id')) {
      context.handle(
        _historyIdMeta,
        historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta),
      );
    }
    if (data.containsKey('search_id')) {
      context.handle(
        _searchIdMeta,
        searchId.isAcceptableOrUnknown(data['search_id']!, _searchIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Favourite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favourite(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      quote:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}quote'],
          )!,
      quoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quote_id'],
      ),
      ownQuoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}own_quote_id'],
      ),
      historyId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}history_id'],
      ),
      searchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}search_id'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $FavouritesTable createAlias(String alias) {
    return $FavouritesTable(attachedDatabase, alias);
  }
}

class Favourite extends DataClass implements Insertable<Favourite> {
  final int id;
  final String quote;
  final int? quoteId;
  final int? ownQuoteId;
  final int? historyId;
  final int? searchId;
  final String createdAt;
  const Favourite({
    required this.id,
    required this.quote,
    this.quoteId,
    this.ownQuoteId,
    this.historyId,
    this.searchId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quote'] = Variable<String>(quote);
    if (!nullToAbsent || quoteId != null) {
      map['quote_id'] = Variable<int>(quoteId);
    }
    if (!nullToAbsent || ownQuoteId != null) {
      map['own_quote_id'] = Variable<int>(ownQuoteId);
    }
    if (!nullToAbsent || historyId != null) {
      map['history_id'] = Variable<int>(historyId);
    }
    if (!nullToAbsent || searchId != null) {
      map['search_id'] = Variable<int>(searchId);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  FavouritesCompanion toCompanion(bool nullToAbsent) {
    return FavouritesCompanion(
      id: Value(id),
      quote: Value(quote),
      quoteId:
          quoteId == null && nullToAbsent
              ? const Value.absent()
              : Value(quoteId),
      ownQuoteId:
          ownQuoteId == null && nullToAbsent
              ? const Value.absent()
              : Value(ownQuoteId),
      historyId:
          historyId == null && nullToAbsent
              ? const Value.absent()
              : Value(historyId),
      searchId:
          searchId == null && nullToAbsent
              ? const Value.absent()
              : Value(searchId),
      createdAt: Value(createdAt),
    );
  }

  factory Favourite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favourite(
      id: serializer.fromJson<int>(json['id']),
      quote: serializer.fromJson<String>(json['quote']),
      quoteId: serializer.fromJson<int?>(json['quoteId']),
      ownQuoteId: serializer.fromJson<int?>(json['ownQuoteId']),
      historyId: serializer.fromJson<int?>(json['historyId']),
      searchId: serializer.fromJson<int?>(json['searchId']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quote': serializer.toJson<String>(quote),
      'quoteId': serializer.toJson<int?>(quoteId),
      'ownQuoteId': serializer.toJson<int?>(ownQuoteId),
      'historyId': serializer.toJson<int?>(historyId),
      'searchId': serializer.toJson<int?>(searchId),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Favourite copyWith({
    int? id,
    String? quote,
    Value<int?> quoteId = const Value.absent(),
    Value<int?> ownQuoteId = const Value.absent(),
    Value<int?> historyId = const Value.absent(),
    Value<int?> searchId = const Value.absent(),
    String? createdAt,
  }) => Favourite(
    id: id ?? this.id,
    quote: quote ?? this.quote,
    quoteId: quoteId.present ? quoteId.value : this.quoteId,
    ownQuoteId: ownQuoteId.present ? ownQuoteId.value : this.ownQuoteId,
    historyId: historyId.present ? historyId.value : this.historyId,
    searchId: searchId.present ? searchId.value : this.searchId,
    createdAt: createdAt ?? this.createdAt,
  );
  Favourite copyWithCompanion(FavouritesCompanion data) {
    return Favourite(
      id: data.id.present ? data.id.value : this.id,
      quote: data.quote.present ? data.quote.value : this.quote,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
      ownQuoteId:
          data.ownQuoteId.present ? data.ownQuoteId.value : this.ownQuoteId,
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
      searchId: data.searchId.present ? data.searchId.value : this.searchId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favourite(')
          ..write('id: $id, ')
          ..write('quote: $quote, ')
          ..write('quoteId: $quoteId, ')
          ..write('ownQuoteId: $ownQuoteId, ')
          ..write('historyId: $historyId, ')
          ..write('searchId: $searchId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    quote,
    quoteId,
    ownQuoteId,
    historyId,
    searchId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favourite &&
          other.id == this.id &&
          other.quote == this.quote &&
          other.quoteId == this.quoteId &&
          other.ownQuoteId == this.ownQuoteId &&
          other.historyId == this.historyId &&
          other.searchId == this.searchId &&
          other.createdAt == this.createdAt);
}

class FavouritesCompanion extends UpdateCompanion<Favourite> {
  final Value<int> id;
  final Value<String> quote;
  final Value<int?> quoteId;
  final Value<int?> ownQuoteId;
  final Value<int?> historyId;
  final Value<int?> searchId;
  final Value<String> createdAt;
  const FavouritesCompanion({
    this.id = const Value.absent(),
    this.quote = const Value.absent(),
    this.quoteId = const Value.absent(),
    this.ownQuoteId = const Value.absent(),
    this.historyId = const Value.absent(),
    this.searchId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavouritesCompanion.insert({
    this.id = const Value.absent(),
    required String quote,
    this.quoteId = const Value.absent(),
    this.ownQuoteId = const Value.absent(),
    this.historyId = const Value.absent(),
    this.searchId = const Value.absent(),
    required String createdAt,
  }) : quote = Value(quote),
       createdAt = Value(createdAt);
  static Insertable<Favourite> custom({
    Expression<int>? id,
    Expression<String>? quote,
    Expression<int>? quoteId,
    Expression<int>? ownQuoteId,
    Expression<int>? historyId,
    Expression<int>? searchId,
    Expression<String>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quote != null) 'quote': quote,
      if (quoteId != null) 'quote_id': quoteId,
      if (ownQuoteId != null) 'own_quote_id': ownQuoteId,
      if (historyId != null) 'history_id': historyId,
      if (searchId != null) 'search_id': searchId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavouritesCompanion copyWith({
    Value<int>? id,
    Value<String>? quote,
    Value<int?>? quoteId,
    Value<int?>? ownQuoteId,
    Value<int?>? historyId,
    Value<int?>? searchId,
    Value<String>? createdAt,
  }) {
    return FavouritesCompanion(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      quoteId: quoteId ?? this.quoteId,
      ownQuoteId: ownQuoteId ?? this.ownQuoteId,
      historyId: historyId ?? this.historyId,
      searchId: searchId ?? this.searchId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quote.present) {
      map['quote'] = Variable<String>(quote.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<int>(quoteId.value);
    }
    if (ownQuoteId.present) {
      map['own_quote_id'] = Variable<int>(ownQuoteId.value);
    }
    if (historyId.present) {
      map['history_id'] = Variable<int>(historyId.value);
    }
    if (searchId.present) {
      map['search_id'] = Variable<int>(searchId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavouritesCompanion(')
          ..write('id: $id, ')
          ..write('quote: $quote, ')
          ..write('quoteId: $quoteId, ')
          ..write('ownQuoteId: $ownQuoteId, ')
          ..write('historyId: $historyId, ')
          ..write('searchId: $searchId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CollectionsFavouritesTable extends CollectionsFavourites
    with TableInfo<$CollectionsFavouritesTable, CollectionsFavourite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsFavouritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES CollectionsTable(id) NOT NULL',
  );
  static const VerificationMeta _favouriteIdMeta = const VerificationMeta(
    'favouriteId',
  );
  @override
  late final GeneratedColumn<int> favouriteId = GeneratedColumn<int>(
    'favourite_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES Favourites(id) NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, collectionId, favouriteId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections_favourites';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionsFavourite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('favourite_id')) {
      context.handle(
        _favouriteIdMeta,
        favouriteId.isAcceptableOrUnknown(
          data['favourite_id']!,
          _favouriteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_favouriteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionsFavourite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionsFavourite(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      collectionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}collection_id'],
          )!,
      favouriteId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}favourite_id'],
          )!,
    );
  }

  @override
  $CollectionsFavouritesTable createAlias(String alias) {
    return $CollectionsFavouritesTable(attachedDatabase, alias);
  }
}

class CollectionsFavourite extends DataClass
    implements Insertable<CollectionsFavourite> {
  final int id;
  final int collectionId;
  final int favouriteId;
  const CollectionsFavourite({
    required this.id,
    required this.collectionId,
    required this.favouriteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['favourite_id'] = Variable<int>(favouriteId);
    return map;
  }

  CollectionsFavouritesCompanion toCompanion(bool nullToAbsent) {
    return CollectionsFavouritesCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      favouriteId: Value(favouriteId),
    );
  }

  factory CollectionsFavourite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionsFavourite(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      favouriteId: serializer.fromJson<int>(json['favouriteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'favouriteId': serializer.toJson<int>(favouriteId),
    };
  }

  CollectionsFavourite copyWith({
    int? id,
    int? collectionId,
    int? favouriteId,
  }) => CollectionsFavourite(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    favouriteId: favouriteId ?? this.favouriteId,
  );
  CollectionsFavourite copyWithCompanion(CollectionsFavouritesCompanion data) {
    return CollectionsFavourite(
      id: data.id.present ? data.id.value : this.id,
      collectionId:
          data.collectionId.present
              ? data.collectionId.value
              : this.collectionId,
      favouriteId:
          data.favouriteId.present ? data.favouriteId.value : this.favouriteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsFavourite(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('favouriteId: $favouriteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, collectionId, favouriteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionsFavourite &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.favouriteId == this.favouriteId);
}

class CollectionsFavouritesCompanion
    extends UpdateCompanion<CollectionsFavourite> {
  final Value<int> id;
  final Value<int> collectionId;
  final Value<int> favouriteId;
  const CollectionsFavouritesCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.favouriteId = const Value.absent(),
  });
  CollectionsFavouritesCompanion.insert({
    this.id = const Value.absent(),
    required int collectionId,
    required int favouriteId,
  }) : collectionId = Value(collectionId),
       favouriteId = Value(favouriteId);
  static Insertable<CollectionsFavourite> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<int>? favouriteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (favouriteId != null) 'favourite_id': favouriteId,
    });
  }

  CollectionsFavouritesCompanion copyWith({
    Value<int>? id,
    Value<int>? collectionId,
    Value<int>? favouriteId,
  }) {
    return CollectionsFavouritesCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      favouriteId: favouriteId ?? this.favouriteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (favouriteId.present) {
      map['favourite_id'] = Variable<int>(favouriteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsFavouritesCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('favouriteId: $favouriteId')
          ..write(')'))
        .toString();
  }
}

class $OwnQuotesTableTable extends OwnQuotesTable
    with TableInfo<$OwnQuotesTableTable, OwnQuotesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OwnQuotesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _quoteTextMeta = const VerificationMeta(
    'quoteText',
  );
  @override
  late final GeneratedColumn<String> quoteText = GeneratedColumn<String>(
    'quote_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, quoteText, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'own_quotes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<OwnQuotesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('quote_text')) {
      context.handle(
        _quoteTextMeta,
        quoteText.isAcceptableOrUnknown(data['quote_text']!, _quoteTextMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OwnQuotesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OwnQuotesTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      quoteText:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}quote_text'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $OwnQuotesTableTable createAlias(String alias) {
    return $OwnQuotesTableTable(attachedDatabase, alias);
  }
}

class OwnQuotesTableData extends DataClass
    implements Insertable<OwnQuotesTableData> {
  final int id;
  final String quoteText;
  final DateTime createdAt;
  const OwnQuotesTableData({
    required this.id,
    required this.quoteText,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['quote_text'] = Variable<String>(quoteText);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  OwnQuotesTableCompanion toCompanion(bool nullToAbsent) {
    return OwnQuotesTableCompanion(
      id: Value(id),
      quoteText: Value(quoteText),
      createdAt: Value(createdAt),
    );
  }

  factory OwnQuotesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OwnQuotesTableData(
      id: serializer.fromJson<int>(json['id']),
      quoteText: serializer.fromJson<String>(json['quoteText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'quoteText': serializer.toJson<String>(quoteText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  OwnQuotesTableData copyWith({
    int? id,
    String? quoteText,
    DateTime? createdAt,
  }) => OwnQuotesTableData(
    id: id ?? this.id,
    quoteText: quoteText ?? this.quoteText,
    createdAt: createdAt ?? this.createdAt,
  );
  OwnQuotesTableData copyWithCompanion(OwnQuotesTableCompanion data) {
    return OwnQuotesTableData(
      id: data.id.present ? data.id.value : this.id,
      quoteText: data.quoteText.present ? data.quoteText.value : this.quoteText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OwnQuotesTableData(')
          ..write('id: $id, ')
          ..write('quoteText: $quoteText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, quoteText, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OwnQuotesTableData &&
          other.id == this.id &&
          other.quoteText == this.quoteText &&
          other.createdAt == this.createdAt);
}

class OwnQuotesTableCompanion extends UpdateCompanion<OwnQuotesTableData> {
  final Value<int> id;
  final Value<String> quoteText;
  final Value<DateTime> createdAt;
  const OwnQuotesTableCompanion({
    this.id = const Value.absent(),
    this.quoteText = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  OwnQuotesTableCompanion.insert({
    this.id = const Value.absent(),
    required String quoteText,
    this.createdAt = const Value.absent(),
  }) : quoteText = Value(quoteText);
  static Insertable<OwnQuotesTableData> custom({
    Expression<int>? id,
    Expression<String>? quoteText,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quoteText != null) 'quote_text': quoteText,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  OwnQuotesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? quoteText,
    Value<DateTime>? createdAt,
  }) {
    return OwnQuotesTableCompanion(
      id: id ?? this.id,
      quoteText: quoteText ?? this.quoteText,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (quoteText.present) {
      map['quote_text'] = Variable<String>(quoteText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OwnQuotesTableCompanion(')
          ..write('id: $id, ')
          ..write('quoteText: $quoteText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CollectionsOwnQuotesTableTable extends CollectionsOwnQuotesTable
    with
        TableInfo<
          $CollectionsOwnQuotesTableTable,
          CollectionsOwnQuotesTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsOwnQuotesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES CollectionsTable(id) NOT NULL',
  );
  static const VerificationMeta _ownQuoteIdMeta = const VerificationMeta(
    'ownQuoteId',
  );
  @override
  late final GeneratedColumn<int> ownQuoteId = GeneratedColumn<int>(
    'own_quote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES OwnQuotesTable(id) NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, collectionId, ownQuoteId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections_own_quotes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionsOwnQuotesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('own_quote_id')) {
      context.handle(
        _ownQuoteIdMeta,
        ownQuoteId.isAcceptableOrUnknown(
          data['own_quote_id']!,
          _ownQuoteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ownQuoteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionsOwnQuotesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionsOwnQuotesTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      collectionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}collection_id'],
          )!,
      ownQuoteId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}own_quote_id'],
          )!,
    );
  }

  @override
  $CollectionsOwnQuotesTableTable createAlias(String alias) {
    return $CollectionsOwnQuotesTableTable(attachedDatabase, alias);
  }
}

class CollectionsOwnQuotesTableData extends DataClass
    implements Insertable<CollectionsOwnQuotesTableData> {
  final int id;
  final int collectionId;
  final int ownQuoteId;
  const CollectionsOwnQuotesTableData({
    required this.id,
    required this.collectionId,
    required this.ownQuoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['own_quote_id'] = Variable<int>(ownQuoteId);
    return map;
  }

  CollectionsOwnQuotesTableCompanion toCompanion(bool nullToAbsent) {
    return CollectionsOwnQuotesTableCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      ownQuoteId: Value(ownQuoteId),
    );
  }

  factory CollectionsOwnQuotesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionsOwnQuotesTableData(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      ownQuoteId: serializer.fromJson<int>(json['ownQuoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'ownQuoteId': serializer.toJson<int>(ownQuoteId),
    };
  }

  CollectionsOwnQuotesTableData copyWith({
    int? id,
    int? collectionId,
    int? ownQuoteId,
  }) => CollectionsOwnQuotesTableData(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    ownQuoteId: ownQuoteId ?? this.ownQuoteId,
  );
  CollectionsOwnQuotesTableData copyWithCompanion(
    CollectionsOwnQuotesTableCompanion data,
  ) {
    return CollectionsOwnQuotesTableData(
      id: data.id.present ? data.id.value : this.id,
      collectionId:
          data.collectionId.present
              ? data.collectionId.value
              : this.collectionId,
      ownQuoteId:
          data.ownQuoteId.present ? data.ownQuoteId.value : this.ownQuoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsOwnQuotesTableData(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('ownQuoteId: $ownQuoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, collectionId, ownQuoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionsOwnQuotesTableData &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.ownQuoteId == this.ownQuoteId);
}

class CollectionsOwnQuotesTableCompanion
    extends UpdateCompanion<CollectionsOwnQuotesTableData> {
  final Value<int> id;
  final Value<int> collectionId;
  final Value<int> ownQuoteId;
  const CollectionsOwnQuotesTableCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.ownQuoteId = const Value.absent(),
  });
  CollectionsOwnQuotesTableCompanion.insert({
    this.id = const Value.absent(),
    required int collectionId,
    required int ownQuoteId,
  }) : collectionId = Value(collectionId),
       ownQuoteId = Value(ownQuoteId);
  static Insertable<CollectionsOwnQuotesTableData> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<int>? ownQuoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (ownQuoteId != null) 'own_quote_id': ownQuoteId,
    });
  }

  CollectionsOwnQuotesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? collectionId,
    Value<int>? ownQuoteId,
  }) {
    return CollectionsOwnQuotesTableCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      ownQuoteId: ownQuoteId ?? this.ownQuoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (ownQuoteId.present) {
      map['own_quote_id'] = Variable<int>(ownQuoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsOwnQuotesTableCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('ownQuoteId: $ownQuoteId')
          ..write(')'))
        .toString();
  }
}

class $CollectionsHistoryQuotesTable extends CollectionsHistoryQuotes
    with TableInfo<$CollectionsHistoryQuotesTable, CollectionsHistoryQuote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsHistoryQuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES CollectionsTable(id) NOT NULL',
  );
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<int> quoteId = GeneratedColumn<int>(
    'quote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES Quotes(id) NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, collectionId, quoteId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections_history_quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionsHistoryQuote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionsHistoryQuote map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionsHistoryQuote(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      collectionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}collection_id'],
          )!,
      quoteId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}quote_id'],
          )!,
    );
  }

  @override
  $CollectionsHistoryQuotesTable createAlias(String alias) {
    return $CollectionsHistoryQuotesTable(attachedDatabase, alias);
  }
}

class CollectionsHistoryQuote extends DataClass
    implements Insertable<CollectionsHistoryQuote> {
  final int id;
  final int collectionId;
  final int quoteId;
  const CollectionsHistoryQuote({
    required this.id,
    required this.collectionId,
    required this.quoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['quote_id'] = Variable<int>(quoteId);
    return map;
  }

  CollectionsHistoryQuotesCompanion toCompanion(bool nullToAbsent) {
    return CollectionsHistoryQuotesCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      quoteId: Value(quoteId),
    );
  }

  factory CollectionsHistoryQuote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionsHistoryQuote(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      quoteId: serializer.fromJson<int>(json['quoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'quoteId': serializer.toJson<int>(quoteId),
    };
  }

  CollectionsHistoryQuote copyWith({
    int? id,
    int? collectionId,
    int? quoteId,
  }) => CollectionsHistoryQuote(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    quoteId: quoteId ?? this.quoteId,
  );
  CollectionsHistoryQuote copyWithCompanion(
    CollectionsHistoryQuotesCompanion data,
  ) {
    return CollectionsHistoryQuote(
      id: data.id.present ? data.id.value : this.id,
      collectionId:
          data.collectionId.present
              ? data.collectionId.value
              : this.collectionId,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsHistoryQuote(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('quoteId: $quoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, collectionId, quoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionsHistoryQuote &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.quoteId == this.quoteId);
}

class CollectionsHistoryQuotesCompanion
    extends UpdateCompanion<CollectionsHistoryQuote> {
  final Value<int> id;
  final Value<int> collectionId;
  final Value<int> quoteId;
  const CollectionsHistoryQuotesCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.quoteId = const Value.absent(),
  });
  CollectionsHistoryQuotesCompanion.insert({
    this.id = const Value.absent(),
    required int collectionId,
    required int quoteId,
  }) : collectionId = Value(collectionId),
       quoteId = Value(quoteId);
  static Insertable<CollectionsHistoryQuote> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<int>? quoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (quoteId != null) 'quote_id': quoteId,
    });
  }

  CollectionsHistoryQuotesCompanion copyWith({
    Value<int>? id,
    Value<int>? collectionId,
    Value<int>? quoteId,
  }) {
    return CollectionsHistoryQuotesCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      quoteId: quoteId ?? this.quoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<int>(quoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsHistoryQuotesCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('quoteId: $quoteId')
          ..write(')'))
        .toString();
  }
}

class $CollectionsSearchQuotesTable extends CollectionsSearchQuotes
    with TableInfo<$CollectionsSearchQuotesTable, CollectionsSearchQuote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsSearchQuotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<int> collectionId = GeneratedColumn<int>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES CollectionsTable(id) NOT NULL',
  );
  static const VerificationMeta _quoteIdMeta = const VerificationMeta(
    'quoteId',
  );
  @override
  late final GeneratedColumn<int> quoteId = GeneratedColumn<int>(
    'quote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES Quotes(id) NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, collectionId, quoteId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections_search_quotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionsSearchQuote> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('quote_id')) {
      context.handle(
        _quoteIdMeta,
        quoteId.isAcceptableOrUnknown(data['quote_id']!, _quoteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_quoteIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionsSearchQuote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionsSearchQuote(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      collectionId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}collection_id'],
          )!,
      quoteId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}quote_id'],
          )!,
    );
  }

  @override
  $CollectionsSearchQuotesTable createAlias(String alias) {
    return $CollectionsSearchQuotesTable(attachedDatabase, alias);
  }
}

class CollectionsSearchQuote extends DataClass
    implements Insertable<CollectionsSearchQuote> {
  final int id;
  final int collectionId;
  final int quoteId;
  const CollectionsSearchQuote({
    required this.id,
    required this.collectionId,
    required this.quoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['collection_id'] = Variable<int>(collectionId);
    map['quote_id'] = Variable<int>(quoteId);
    return map;
  }

  CollectionsSearchQuotesCompanion toCompanion(bool nullToAbsent) {
    return CollectionsSearchQuotesCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      quoteId: Value(quoteId),
    );
  }

  factory CollectionsSearchQuote.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionsSearchQuote(
      id: serializer.fromJson<int>(json['id']),
      collectionId: serializer.fromJson<int>(json['collectionId']),
      quoteId: serializer.fromJson<int>(json['quoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'collectionId': serializer.toJson<int>(collectionId),
      'quoteId': serializer.toJson<int>(quoteId),
    };
  }

  CollectionsSearchQuote copyWith({int? id, int? collectionId, int? quoteId}) =>
      CollectionsSearchQuote(
        id: id ?? this.id,
        collectionId: collectionId ?? this.collectionId,
        quoteId: quoteId ?? this.quoteId,
      );
  CollectionsSearchQuote copyWithCompanion(
    CollectionsSearchQuotesCompanion data,
  ) {
    return CollectionsSearchQuote(
      id: data.id.present ? data.id.value : this.id,
      collectionId:
          data.collectionId.present
              ? data.collectionId.value
              : this.collectionId,
      quoteId: data.quoteId.present ? data.quoteId.value : this.quoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsSearchQuote(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('quoteId: $quoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, collectionId, quoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionsSearchQuote &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.quoteId == this.quoteId);
}

class CollectionsSearchQuotesCompanion
    extends UpdateCompanion<CollectionsSearchQuote> {
  final Value<int> id;
  final Value<int> collectionId;
  final Value<int> quoteId;
  const CollectionsSearchQuotesCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.quoteId = const Value.absent(),
  });
  CollectionsSearchQuotesCompanion.insert({
    this.id = const Value.absent(),
    required int collectionId,
    required int quoteId,
  }) : collectionId = Value(collectionId),
       quoteId = Value(quoteId);
  static Insertable<CollectionsSearchQuote> custom({
    Expression<int>? id,
    Expression<int>? collectionId,
    Expression<int>? quoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (quoteId != null) 'quote_id': quoteId,
    });
  }

  CollectionsSearchQuotesCompanion copyWith({
    Value<int>? id,
    Value<int>? collectionId,
    Value<int>? quoteId,
  }) {
    return CollectionsSearchQuotesCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      quoteId: quoteId ?? this.quoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<int>(collectionId.value);
    }
    if (quoteId.present) {
      map['quote_id'] = Variable<int>(quoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsSearchQuotesCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('quoteId: $quoteId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CollectionsTableTable collectionsTable = $CollectionsTableTable(
    this,
  );
  late final $QuotesTable quotes = $QuotesTable(this);
  late final $FavouritesTable favourites = $FavouritesTable(this);
  late final $CollectionsFavouritesTable collectionsFavourites =
      $CollectionsFavouritesTable(this);
  late final $OwnQuotesTableTable ownQuotesTable = $OwnQuotesTableTable(this);
  late final $CollectionsOwnQuotesTableTable collectionsOwnQuotesTable =
      $CollectionsOwnQuotesTableTable(this);
  late final $CollectionsHistoryQuotesTable collectionsHistoryQuotes =
      $CollectionsHistoryQuotesTable(this);
  late final $CollectionsSearchQuotesTable collectionsSearchQuotes =
      $CollectionsSearchQuotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    collectionsTable,
    quotes,
    favourites,
    collectionsFavourites,
    ownQuotesTable,
    collectionsOwnQuotesTable,
    collectionsHistoryQuotes,
    collectionsSearchQuotes,
  ];
}

typedef $$CollectionsTableTableCreateCompanionBuilder =
    CollectionsTableCompanion Function({
      Value<int> id,
      required String name,
      required String createdAt,
    });
typedef $$CollectionsTableTableUpdateCompanionBuilder =
    CollectionsTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> createdAt,
    });

class $$CollectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsTableTable> {
  $$CollectionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CollectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsTableTable> {
  $$CollectionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CollectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsTableTable> {
  $$CollectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CollectionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionsTableTable,
          CollectionsTableData,
          $$CollectionsTableTableFilterComposer,
          $$CollectionsTableTableOrderingComposer,
          $$CollectionsTableTableAnnotationComposer,
          $$CollectionsTableTableCreateCompanionBuilder,
          $$CollectionsTableTableUpdateCompanionBuilder,
          (
            CollectionsTableData,
            BaseReferences<
              _$AppDatabase,
              $CollectionsTableTable,
              CollectionsTableData
            >,
          ),
          CollectionsTableData,
          PrefetchHooks Function()
        > {
  $$CollectionsTableTableTableManager(
    _$AppDatabase db,
    $CollectionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$CollectionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CollectionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CollectionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => CollectionsTableCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String createdAt,
              }) => CollectionsTableCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CollectionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionsTableTable,
      CollectionsTableData,
      $$CollectionsTableTableFilterComposer,
      $$CollectionsTableTableOrderingComposer,
      $$CollectionsTableTableAnnotationComposer,
      $$CollectionsTableTableCreateCompanionBuilder,
      $$CollectionsTableTableUpdateCompanionBuilder,
      (
        CollectionsTableData,
        BaseReferences<
          _$AppDatabase,
          $CollectionsTableTable,
          CollectionsTableData
        >,
      ),
      CollectionsTableData,
      PrefetchHooks Function()
    >;
typedef $$QuotesTableCreateCompanionBuilder =
    QuotesCompanion Function({
      Value<int> id,
      required String quoteText,
      Value<String?> author,
      Value<DateTime> createdAt,
      Value<DateTime?> shownAt,
    });
typedef $$QuotesTableUpdateCompanionBuilder =
    QuotesCompanion Function({
      Value<int> id,
      Value<String> quoteText,
      Value<String?> author,
      Value<DateTime> createdAt,
      Value<DateTime?> shownAt,
    });

final class $$QuotesTableReferences
    extends BaseReferences<_$AppDatabase, $QuotesTable, Quote> {
  $$QuotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $CollectionsHistoryQuotesTable,
    List<CollectionsHistoryQuote>
  >
  _collectionsHistoryQuotesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionsHistoryQuotes,
        aliasName: $_aliasNameGenerator(
          db.quotes.id,
          db.collectionsHistoryQuotes.quoteId,
        ),
      );

  $$CollectionsHistoryQuotesTableProcessedTableManager
  get collectionsHistoryQuotesRefs {
    final manager = $$CollectionsHistoryQuotesTableTableManager(
      $_db,
      $_db.collectionsHistoryQuotes,
    ).filter((f) => f.quoteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionsHistoryQuotesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CollectionsSearchQuotesTable,
    List<CollectionsSearchQuote>
  >
  _collectionsSearchQuotesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionsSearchQuotes,
        aliasName: $_aliasNameGenerator(
          db.quotes.id,
          db.collectionsSearchQuotes.quoteId,
        ),
      );

  $$CollectionsSearchQuotesTableProcessedTableManager
  get collectionsSearchQuotesRefs {
    final manager = $$CollectionsSearchQuotesTableTableManager(
      $_db,
      $_db.collectionsSearchQuotes,
    ).filter((f) => f.quoteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionsSearchQuotesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$QuotesTableFilterComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteText => $composableBuilder(
    column: $table.quoteText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get shownAt => $composableBuilder(
    column: $table.shownAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> collectionsHistoryQuotesRefs(
    Expression<bool> Function($$CollectionsHistoryQuotesTableFilterComposer f)
    f,
  ) {
    final $$CollectionsHistoryQuotesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionsHistoryQuotes,
          getReferencedColumn: (t) => t.quoteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionsHistoryQuotesTableFilterComposer(
                $db: $db,
                $table: $db.collectionsHistoryQuotes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> collectionsSearchQuotesRefs(
    Expression<bool> Function($$CollectionsSearchQuotesTableFilterComposer f) f,
  ) {
    final $$CollectionsSearchQuotesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionsSearchQuotes,
          getReferencedColumn: (t) => t.quoteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionsSearchQuotesTableFilterComposer(
                $db: $db,
                $table: $db.collectionsSearchQuotes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$QuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteText => $composableBuilder(
    column: $table.quoteText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get shownAt => $composableBuilder(
    column: $table.shownAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuotesTable> {
  $$QuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get quoteText =>
      $composableBuilder(column: $table.quoteText, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get shownAt =>
      $composableBuilder(column: $table.shownAt, builder: (column) => column);

  Expression<T> collectionsHistoryQuotesRefs<T extends Object>(
    Expression<T> Function($$CollectionsHistoryQuotesTableAnnotationComposer a)
    f,
  ) {
    final $$CollectionsHistoryQuotesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionsHistoryQuotes,
          getReferencedColumn: (t) => t.quoteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionsHistoryQuotesTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionsHistoryQuotes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> collectionsSearchQuotesRefs<T extends Object>(
    Expression<T> Function($$CollectionsSearchQuotesTableAnnotationComposer a)
    f,
  ) {
    final $$CollectionsSearchQuotesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionsSearchQuotes,
          getReferencedColumn: (t) => t.quoteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionsSearchQuotesTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionsSearchQuotes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$QuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuotesTable,
          Quote,
          $$QuotesTableFilterComposer,
          $$QuotesTableOrderingComposer,
          $$QuotesTableAnnotationComposer,
          $$QuotesTableCreateCompanionBuilder,
          $$QuotesTableUpdateCompanionBuilder,
          (Quote, $$QuotesTableReferences),
          Quote,
          PrefetchHooks Function({
            bool collectionsHistoryQuotesRefs,
            bool collectionsSearchQuotesRefs,
          })
        > {
  $$QuotesTableTableManager(_$AppDatabase db, $QuotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$QuotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$QuotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$QuotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> quoteText = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> shownAt = const Value.absent(),
              }) => QuotesCompanion(
                id: id,
                quoteText: quoteText,
                author: author,
                createdAt: createdAt,
                shownAt: shownAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String quoteText,
                Value<String?> author = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> shownAt = const Value.absent(),
              }) => QuotesCompanion.insert(
                id: id,
                quoteText: quoteText,
                author: author,
                createdAt: createdAt,
                shownAt: shownAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$QuotesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            collectionsHistoryQuotesRefs = false,
            collectionsSearchQuotesRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (collectionsHistoryQuotesRefs) db.collectionsHistoryQuotes,
                if (collectionsSearchQuotesRefs) db.collectionsSearchQuotes,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (collectionsHistoryQuotesRefs)
                    await $_getPrefetchedData<
                      Quote,
                      $QuotesTable,
                      CollectionsHistoryQuote
                    >(
                      currentTable: table,
                      referencedTable: $$QuotesTableReferences
                          ._collectionsHistoryQuotesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$QuotesTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionsHistoryQuotesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.quoteId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (collectionsSearchQuotesRefs)
                    await $_getPrefetchedData<
                      Quote,
                      $QuotesTable,
                      CollectionsSearchQuote
                    >(
                      currentTable: table,
                      referencedTable: $$QuotesTableReferences
                          ._collectionsSearchQuotesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$QuotesTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionsSearchQuotesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.quoteId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$QuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuotesTable,
      Quote,
      $$QuotesTableFilterComposer,
      $$QuotesTableOrderingComposer,
      $$QuotesTableAnnotationComposer,
      $$QuotesTableCreateCompanionBuilder,
      $$QuotesTableUpdateCompanionBuilder,
      (Quote, $$QuotesTableReferences),
      Quote,
      PrefetchHooks Function({
        bool collectionsHistoryQuotesRefs,
        bool collectionsSearchQuotesRefs,
      })
    >;
typedef $$FavouritesTableCreateCompanionBuilder =
    FavouritesCompanion Function({
      Value<int> id,
      required String quote,
      Value<int?> quoteId,
      Value<int?> ownQuoteId,
      Value<int?> historyId,
      Value<int?> searchId,
      required String createdAt,
    });
typedef $$FavouritesTableUpdateCompanionBuilder =
    FavouritesCompanion Function({
      Value<int> id,
      Value<String> quote,
      Value<int?> quoteId,
      Value<int?> ownQuoteId,
      Value<int?> historyId,
      Value<int?> searchId,
      Value<String> createdAt,
    });

final class $$FavouritesTableReferences
    extends BaseReferences<_$AppDatabase, $FavouritesTable, Favourite> {
  $$FavouritesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $QuotesTable _quoteIdTable(_$AppDatabase db) => db.quotes.createAlias(
    $_aliasNameGenerator(db.favourites.quoteId, db.quotes.id),
  );

  $$QuotesTableProcessedTableManager? get quoteId {
    final $_column = $_itemColumn<int>('quote_id');
    if ($_column == null) return null;
    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $QuotesTable _historyIdTable(_$AppDatabase db) => db.quotes
      .createAlias($_aliasNameGenerator(db.favourites.historyId, db.quotes.id));

  $$QuotesTableProcessedTableManager? get historyId {
    final $_column = $_itemColumn<int>('history_id');
    if ($_column == null) return null;
    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_historyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $QuotesTable _searchIdTable(_$AppDatabase db) => db.quotes.createAlias(
    $_aliasNameGenerator(db.favourites.searchId, db.quotes.id),
  );

  $$QuotesTableProcessedTableManager? get searchId {
    final $_column = $_itemColumn<int>('search_id');
    if ($_column == null) return null;
    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_searchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CollectionsFavouritesTable,
    List<CollectionsFavourite>
  >
  _collectionsFavouritesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionsFavourites,
        aliasName: $_aliasNameGenerator(
          db.favourites.id,
          db.collectionsFavourites.favouriteId,
        ),
      );

  $$CollectionsFavouritesTableProcessedTableManager
  get collectionsFavouritesRefs {
    final manager = $$CollectionsFavouritesTableTableManager(
      $_db,
      $_db.collectionsFavourites,
    ).filter((f) => f.favouriteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionsFavouritesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FavouritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavouritesTable> {
  $$FavouritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ownQuoteId => $composableBuilder(
    column: $table.ownQuoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$QuotesTableFilterComposer get quoteId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuotesTableFilterComposer get historyId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.historyId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuotesTableFilterComposer get searchId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> collectionsFavouritesRefs(
    Expression<bool> Function($$CollectionsFavouritesTableFilterComposer f) f,
  ) {
    final $$CollectionsFavouritesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionsFavourites,
          getReferencedColumn: (t) => t.favouriteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionsFavouritesTableFilterComposer(
                $db: $db,
                $table: $db.collectionsFavourites,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FavouritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavouritesTable> {
  $$FavouritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quote => $composableBuilder(
    column: $table.quote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownQuoteId => $composableBuilder(
    column: $table.ownQuoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuotesTableOrderingComposer get quoteId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuotesTableOrderingComposer get historyId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.historyId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuotesTableOrderingComposer get searchId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FavouritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavouritesTable> {
  $$FavouritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get quote =>
      $composableBuilder(column: $table.quote, builder: (column) => column);

  GeneratedColumn<int> get ownQuoteId => $composableBuilder(
    column: $table.ownQuoteId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$QuotesTableAnnotationComposer get quoteId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuotesTableAnnotationComposer get historyId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.historyId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$QuotesTableAnnotationComposer get searchId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.searchId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> collectionsFavouritesRefs<T extends Object>(
    Expression<T> Function($$CollectionsFavouritesTableAnnotationComposer a) f,
  ) {
    final $$CollectionsFavouritesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionsFavourites,
          getReferencedColumn: (t) => t.favouriteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionsFavouritesTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionsFavourites,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$FavouritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavouritesTable,
          Favourite,
          $$FavouritesTableFilterComposer,
          $$FavouritesTableOrderingComposer,
          $$FavouritesTableAnnotationComposer,
          $$FavouritesTableCreateCompanionBuilder,
          $$FavouritesTableUpdateCompanionBuilder,
          (Favourite, $$FavouritesTableReferences),
          Favourite,
          PrefetchHooks Function({
            bool quoteId,
            bool historyId,
            bool searchId,
            bool collectionsFavouritesRefs,
          })
        > {
  $$FavouritesTableTableManager(_$AppDatabase db, $FavouritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$FavouritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$FavouritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$FavouritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> quote = const Value.absent(),
                Value<int?> quoteId = const Value.absent(),
                Value<int?> ownQuoteId = const Value.absent(),
                Value<int?> historyId = const Value.absent(),
                Value<int?> searchId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
              }) => FavouritesCompanion(
                id: id,
                quote: quote,
                quoteId: quoteId,
                ownQuoteId: ownQuoteId,
                historyId: historyId,
                searchId: searchId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String quote,
                Value<int?> quoteId = const Value.absent(),
                Value<int?> ownQuoteId = const Value.absent(),
                Value<int?> historyId = const Value.absent(),
                Value<int?> searchId = const Value.absent(),
                required String createdAt,
              }) => FavouritesCompanion.insert(
                id: id,
                quote: quote,
                quoteId: quoteId,
                ownQuoteId: ownQuoteId,
                historyId: historyId,
                searchId: searchId,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$FavouritesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            quoteId = false,
            historyId = false,
            searchId = false,
            collectionsFavouritesRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (collectionsFavouritesRefs) db.collectionsFavourites,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (quoteId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.quoteId,
                            referencedTable: $$FavouritesTableReferences
                                ._quoteIdTable(db),
                            referencedColumn:
                                $$FavouritesTableReferences
                                    ._quoteIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (historyId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.historyId,
                            referencedTable: $$FavouritesTableReferences
                                ._historyIdTable(db),
                            referencedColumn:
                                $$FavouritesTableReferences
                                    ._historyIdTable(db)
                                    .id,
                          )
                          as T;
                }
                if (searchId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.searchId,
                            referencedTable: $$FavouritesTableReferences
                                ._searchIdTable(db),
                            referencedColumn:
                                $$FavouritesTableReferences
                                    ._searchIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (collectionsFavouritesRefs)
                    await $_getPrefetchedData<
                      Favourite,
                      $FavouritesTable,
                      CollectionsFavourite
                    >(
                      currentTable: table,
                      referencedTable: $$FavouritesTableReferences
                          ._collectionsFavouritesRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$FavouritesTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionsFavouritesRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.favouriteId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$FavouritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavouritesTable,
      Favourite,
      $$FavouritesTableFilterComposer,
      $$FavouritesTableOrderingComposer,
      $$FavouritesTableAnnotationComposer,
      $$FavouritesTableCreateCompanionBuilder,
      $$FavouritesTableUpdateCompanionBuilder,
      (Favourite, $$FavouritesTableReferences),
      Favourite,
      PrefetchHooks Function({
        bool quoteId,
        bool historyId,
        bool searchId,
        bool collectionsFavouritesRefs,
      })
    >;
typedef $$CollectionsFavouritesTableCreateCompanionBuilder =
    CollectionsFavouritesCompanion Function({
      Value<int> id,
      required int collectionId,
      required int favouriteId,
    });
typedef $$CollectionsFavouritesTableUpdateCompanionBuilder =
    CollectionsFavouritesCompanion Function({
      Value<int> id,
      Value<int> collectionId,
      Value<int> favouriteId,
    });

final class $$CollectionsFavouritesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionsFavouritesTable,
          CollectionsFavourite
        > {
  $$CollectionsFavouritesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $FavouritesTable _favouriteIdTable(_$AppDatabase db) =>
      db.favourites.createAlias(
        $_aliasNameGenerator(
          db.collectionsFavourites.favouriteId,
          db.favourites.id,
        ),
      );

  $$FavouritesTableProcessedTableManager get favouriteId {
    final $_column = $_itemColumn<int>('favourite_id')!;

    final manager = $$FavouritesTableTableManager(
      $_db,
      $_db.favourites,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_favouriteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CollectionsFavouritesTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsFavouritesTable> {
  $$CollectionsFavouritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  $$FavouritesTableFilterComposer get favouriteId {
    final $$FavouritesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favouriteId,
      referencedTable: $db.favourites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavouritesTableFilterComposer(
            $db: $db,
            $table: $db.favourites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsFavouritesTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsFavouritesTable> {
  $$CollectionsFavouritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  $$FavouritesTableOrderingComposer get favouriteId {
    final $$FavouritesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favouriteId,
      referencedTable: $db.favourites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavouritesTableOrderingComposer(
            $db: $db,
            $table: $db.favourites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsFavouritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsFavouritesTable> {
  $$CollectionsFavouritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  $$FavouritesTableAnnotationComposer get favouriteId {
    final $$FavouritesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favouriteId,
      referencedTable: $db.favourites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FavouritesTableAnnotationComposer(
            $db: $db,
            $table: $db.favourites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsFavouritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionsFavouritesTable,
          CollectionsFavourite,
          $$CollectionsFavouritesTableFilterComposer,
          $$CollectionsFavouritesTableOrderingComposer,
          $$CollectionsFavouritesTableAnnotationComposer,
          $$CollectionsFavouritesTableCreateCompanionBuilder,
          $$CollectionsFavouritesTableUpdateCompanionBuilder,
          (CollectionsFavourite, $$CollectionsFavouritesTableReferences),
          CollectionsFavourite,
          PrefetchHooks Function({bool favouriteId})
        > {
  $$CollectionsFavouritesTableTableManager(
    _$AppDatabase db,
    $CollectionsFavouritesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CollectionsFavouritesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$CollectionsFavouritesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CollectionsFavouritesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<int> favouriteId = const Value.absent(),
              }) => CollectionsFavouritesCompanion(
                id: id,
                collectionId: collectionId,
                favouriteId: favouriteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int collectionId,
                required int favouriteId,
              }) => CollectionsFavouritesCompanion.insert(
                id: id,
                collectionId: collectionId,
                favouriteId: favouriteId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CollectionsFavouritesTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({favouriteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (favouriteId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.favouriteId,
                            referencedTable:
                                $$CollectionsFavouritesTableReferences
                                    ._favouriteIdTable(db),
                            referencedColumn:
                                $$CollectionsFavouritesTableReferences
                                    ._favouriteIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CollectionsFavouritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionsFavouritesTable,
      CollectionsFavourite,
      $$CollectionsFavouritesTableFilterComposer,
      $$CollectionsFavouritesTableOrderingComposer,
      $$CollectionsFavouritesTableAnnotationComposer,
      $$CollectionsFavouritesTableCreateCompanionBuilder,
      $$CollectionsFavouritesTableUpdateCompanionBuilder,
      (CollectionsFavourite, $$CollectionsFavouritesTableReferences),
      CollectionsFavourite,
      PrefetchHooks Function({bool favouriteId})
    >;
typedef $$OwnQuotesTableTableCreateCompanionBuilder =
    OwnQuotesTableCompanion Function({
      Value<int> id,
      required String quoteText,
      Value<DateTime> createdAt,
    });
typedef $$OwnQuotesTableTableUpdateCompanionBuilder =
    OwnQuotesTableCompanion Function({
      Value<int> id,
      Value<String> quoteText,
      Value<DateTime> createdAt,
    });

class $$OwnQuotesTableTableFilterComposer
    extends Composer<_$AppDatabase, $OwnQuotesTableTable> {
  $$OwnQuotesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quoteText => $composableBuilder(
    column: $table.quoteText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OwnQuotesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OwnQuotesTableTable> {
  $$OwnQuotesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quoteText => $composableBuilder(
    column: $table.quoteText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OwnQuotesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OwnQuotesTableTable> {
  $$OwnQuotesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get quoteText =>
      $composableBuilder(column: $table.quoteText, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$OwnQuotesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OwnQuotesTableTable,
          OwnQuotesTableData,
          $$OwnQuotesTableTableFilterComposer,
          $$OwnQuotesTableTableOrderingComposer,
          $$OwnQuotesTableTableAnnotationComposer,
          $$OwnQuotesTableTableCreateCompanionBuilder,
          $$OwnQuotesTableTableUpdateCompanionBuilder,
          (
            OwnQuotesTableData,
            BaseReferences<
              _$AppDatabase,
              $OwnQuotesTableTable,
              OwnQuotesTableData
            >,
          ),
          OwnQuotesTableData,
          PrefetchHooks Function()
        > {
  $$OwnQuotesTableTableTableManager(
    _$AppDatabase db,
    $OwnQuotesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$OwnQuotesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$OwnQuotesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$OwnQuotesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> quoteText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => OwnQuotesTableCompanion(
                id: id,
                quoteText: quoteText,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String quoteText,
                Value<DateTime> createdAt = const Value.absent(),
              }) => OwnQuotesTableCompanion.insert(
                id: id,
                quoteText: quoteText,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OwnQuotesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OwnQuotesTableTable,
      OwnQuotesTableData,
      $$OwnQuotesTableTableFilterComposer,
      $$OwnQuotesTableTableOrderingComposer,
      $$OwnQuotesTableTableAnnotationComposer,
      $$OwnQuotesTableTableCreateCompanionBuilder,
      $$OwnQuotesTableTableUpdateCompanionBuilder,
      (
        OwnQuotesTableData,
        BaseReferences<_$AppDatabase, $OwnQuotesTableTable, OwnQuotesTableData>,
      ),
      OwnQuotesTableData,
      PrefetchHooks Function()
    >;
typedef $$CollectionsOwnQuotesTableTableCreateCompanionBuilder =
    CollectionsOwnQuotesTableCompanion Function({
      Value<int> id,
      required int collectionId,
      required int ownQuoteId,
    });
typedef $$CollectionsOwnQuotesTableTableUpdateCompanionBuilder =
    CollectionsOwnQuotesTableCompanion Function({
      Value<int> id,
      Value<int> collectionId,
      Value<int> ownQuoteId,
    });

class $$CollectionsOwnQuotesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsOwnQuotesTableTable> {
  $$CollectionsOwnQuotesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ownQuoteId => $composableBuilder(
    column: $table.ownQuoteId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CollectionsOwnQuotesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsOwnQuotesTableTable> {
  $$CollectionsOwnQuotesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ownQuoteId => $composableBuilder(
    column: $table.ownQuoteId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CollectionsOwnQuotesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsOwnQuotesTableTable> {
  $$CollectionsOwnQuotesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ownQuoteId => $composableBuilder(
    column: $table.ownQuoteId,
    builder: (column) => column,
  );
}

class $$CollectionsOwnQuotesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionsOwnQuotesTableTable,
          CollectionsOwnQuotesTableData,
          $$CollectionsOwnQuotesTableTableFilterComposer,
          $$CollectionsOwnQuotesTableTableOrderingComposer,
          $$CollectionsOwnQuotesTableTableAnnotationComposer,
          $$CollectionsOwnQuotesTableTableCreateCompanionBuilder,
          $$CollectionsOwnQuotesTableTableUpdateCompanionBuilder,
          (
            CollectionsOwnQuotesTableData,
            BaseReferences<
              _$AppDatabase,
              $CollectionsOwnQuotesTableTable,
              CollectionsOwnQuotesTableData
            >,
          ),
          CollectionsOwnQuotesTableData,
          PrefetchHooks Function()
        > {
  $$CollectionsOwnQuotesTableTableTableManager(
    _$AppDatabase db,
    $CollectionsOwnQuotesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CollectionsOwnQuotesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$CollectionsOwnQuotesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CollectionsOwnQuotesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<int> ownQuoteId = const Value.absent(),
              }) => CollectionsOwnQuotesTableCompanion(
                id: id,
                collectionId: collectionId,
                ownQuoteId: ownQuoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int collectionId,
                required int ownQuoteId,
              }) => CollectionsOwnQuotesTableCompanion.insert(
                id: id,
                collectionId: collectionId,
                ownQuoteId: ownQuoteId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CollectionsOwnQuotesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionsOwnQuotesTableTable,
      CollectionsOwnQuotesTableData,
      $$CollectionsOwnQuotesTableTableFilterComposer,
      $$CollectionsOwnQuotesTableTableOrderingComposer,
      $$CollectionsOwnQuotesTableTableAnnotationComposer,
      $$CollectionsOwnQuotesTableTableCreateCompanionBuilder,
      $$CollectionsOwnQuotesTableTableUpdateCompanionBuilder,
      (
        CollectionsOwnQuotesTableData,
        BaseReferences<
          _$AppDatabase,
          $CollectionsOwnQuotesTableTable,
          CollectionsOwnQuotesTableData
        >,
      ),
      CollectionsOwnQuotesTableData,
      PrefetchHooks Function()
    >;
typedef $$CollectionsHistoryQuotesTableCreateCompanionBuilder =
    CollectionsHistoryQuotesCompanion Function({
      Value<int> id,
      required int collectionId,
      required int quoteId,
    });
typedef $$CollectionsHistoryQuotesTableUpdateCompanionBuilder =
    CollectionsHistoryQuotesCompanion Function({
      Value<int> id,
      Value<int> collectionId,
      Value<int> quoteId,
    });

final class $$CollectionsHistoryQuotesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionsHistoryQuotesTable,
          CollectionsHistoryQuote
        > {
  $$CollectionsHistoryQuotesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuotesTable _quoteIdTable(_$AppDatabase db) => db.quotes.createAlias(
    $_aliasNameGenerator(db.collectionsHistoryQuotes.quoteId, db.quotes.id),
  );

  $$QuotesTableProcessedTableManager get quoteId {
    final $_column = $_itemColumn<int>('quote_id')!;

    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CollectionsHistoryQuotesTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsHistoryQuotesTable> {
  $$CollectionsHistoryQuotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  $$QuotesTableFilterComposer get quoteId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsHistoryQuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsHistoryQuotesTable> {
  $$CollectionsHistoryQuotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuotesTableOrderingComposer get quoteId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsHistoryQuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsHistoryQuotesTable> {
  $$CollectionsHistoryQuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  $$QuotesTableAnnotationComposer get quoteId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsHistoryQuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionsHistoryQuotesTable,
          CollectionsHistoryQuote,
          $$CollectionsHistoryQuotesTableFilterComposer,
          $$CollectionsHistoryQuotesTableOrderingComposer,
          $$CollectionsHistoryQuotesTableAnnotationComposer,
          $$CollectionsHistoryQuotesTableCreateCompanionBuilder,
          $$CollectionsHistoryQuotesTableUpdateCompanionBuilder,
          (CollectionsHistoryQuote, $$CollectionsHistoryQuotesTableReferences),
          CollectionsHistoryQuote,
          PrefetchHooks Function({bool quoteId})
        > {
  $$CollectionsHistoryQuotesTableTableManager(
    _$AppDatabase db,
    $CollectionsHistoryQuotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CollectionsHistoryQuotesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$CollectionsHistoryQuotesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CollectionsHistoryQuotesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<int> quoteId = const Value.absent(),
              }) => CollectionsHistoryQuotesCompanion(
                id: id,
                collectionId: collectionId,
                quoteId: quoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int collectionId,
                required int quoteId,
              }) => CollectionsHistoryQuotesCompanion.insert(
                id: id,
                collectionId: collectionId,
                quoteId: quoteId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CollectionsHistoryQuotesTableReferences(
                            db,
                            table,
                            e,
                          ),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({quoteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (quoteId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.quoteId,
                            referencedTable:
                                $$CollectionsHistoryQuotesTableReferences
                                    ._quoteIdTable(db),
                            referencedColumn:
                                $$CollectionsHistoryQuotesTableReferences
                                    ._quoteIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CollectionsHistoryQuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionsHistoryQuotesTable,
      CollectionsHistoryQuote,
      $$CollectionsHistoryQuotesTableFilterComposer,
      $$CollectionsHistoryQuotesTableOrderingComposer,
      $$CollectionsHistoryQuotesTableAnnotationComposer,
      $$CollectionsHistoryQuotesTableCreateCompanionBuilder,
      $$CollectionsHistoryQuotesTableUpdateCompanionBuilder,
      (CollectionsHistoryQuote, $$CollectionsHistoryQuotesTableReferences),
      CollectionsHistoryQuote,
      PrefetchHooks Function({bool quoteId})
    >;
typedef $$CollectionsSearchQuotesTableCreateCompanionBuilder =
    CollectionsSearchQuotesCompanion Function({
      Value<int> id,
      required int collectionId,
      required int quoteId,
    });
typedef $$CollectionsSearchQuotesTableUpdateCompanionBuilder =
    CollectionsSearchQuotesCompanion Function({
      Value<int> id,
      Value<int> collectionId,
      Value<int> quoteId,
    });

final class $$CollectionsSearchQuotesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionsSearchQuotesTable,
          CollectionsSearchQuote
        > {
  $$CollectionsSearchQuotesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $QuotesTable _quoteIdTable(_$AppDatabase db) => db.quotes.createAlias(
    $_aliasNameGenerator(db.collectionsSearchQuotes.quoteId, db.quotes.id),
  );

  $$QuotesTableProcessedTableManager get quoteId {
    final $_column = $_itemColumn<int>('quote_id')!;

    final manager = $$QuotesTableTableManager(
      $_db,
      $_db.quotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_quoteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CollectionsSearchQuotesTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsSearchQuotesTable> {
  $$CollectionsSearchQuotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnFilters(column),
  );

  $$QuotesTableFilterComposer get quoteId {
    final $$QuotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableFilterComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsSearchQuotesTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsSearchQuotesTable> {
  $$CollectionsSearchQuotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => ColumnOrderings(column),
  );

  $$QuotesTableOrderingComposer get quoteId {
    final $$QuotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableOrderingComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsSearchQuotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsSearchQuotesTable> {
  $$CollectionsSearchQuotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get collectionId => $composableBuilder(
    column: $table.collectionId,
    builder: (column) => column,
  );

  $$QuotesTableAnnotationComposer get quoteId {
    final $$QuotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.quoteId,
      referencedTable: $db.quotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuotesTableAnnotationComposer(
            $db: $db,
            $table: $db.quotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsSearchQuotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionsSearchQuotesTable,
          CollectionsSearchQuote,
          $$CollectionsSearchQuotesTableFilterComposer,
          $$CollectionsSearchQuotesTableOrderingComposer,
          $$CollectionsSearchQuotesTableAnnotationComposer,
          $$CollectionsSearchQuotesTableCreateCompanionBuilder,
          $$CollectionsSearchQuotesTableUpdateCompanionBuilder,
          (CollectionsSearchQuote, $$CollectionsSearchQuotesTableReferences),
          CollectionsSearchQuote,
          PrefetchHooks Function({bool quoteId})
        > {
  $$CollectionsSearchQuotesTableTableManager(
    _$AppDatabase db,
    $CollectionsSearchQuotesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CollectionsSearchQuotesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$CollectionsSearchQuotesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CollectionsSearchQuotesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> collectionId = const Value.absent(),
                Value<int> quoteId = const Value.absent(),
              }) => CollectionsSearchQuotesCompanion(
                id: id,
                collectionId: collectionId,
                quoteId: quoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int collectionId,
                required int quoteId,
              }) => CollectionsSearchQuotesCompanion.insert(
                id: id,
                collectionId: collectionId,
                quoteId: quoteId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$CollectionsSearchQuotesTableReferences(
                            db,
                            table,
                            e,
                          ),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({quoteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (quoteId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.quoteId,
                            referencedTable:
                                $$CollectionsSearchQuotesTableReferences
                                    ._quoteIdTable(db),
                            referencedColumn:
                                $$CollectionsSearchQuotesTableReferences
                                    ._quoteIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CollectionsSearchQuotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionsSearchQuotesTable,
      CollectionsSearchQuote,
      $$CollectionsSearchQuotesTableFilterComposer,
      $$CollectionsSearchQuotesTableOrderingComposer,
      $$CollectionsSearchQuotesTableAnnotationComposer,
      $$CollectionsSearchQuotesTableCreateCompanionBuilder,
      $$CollectionsSearchQuotesTableUpdateCompanionBuilder,
      (CollectionsSearchQuote, $$CollectionsSearchQuotesTableReferences),
      CollectionsSearchQuote,
      PrefetchHooks Function({bool quoteId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CollectionsTableTableTableManager get collectionsTable =>
      $$CollectionsTableTableTableManager(_db, _db.collectionsTable);
  $$QuotesTableTableManager get quotes =>
      $$QuotesTableTableManager(_db, _db.quotes);
  $$FavouritesTableTableManager get favourites =>
      $$FavouritesTableTableManager(_db, _db.favourites);
  $$CollectionsFavouritesTableTableManager get collectionsFavourites =>
      $$CollectionsFavouritesTableTableManager(_db, _db.collectionsFavourites);
  $$OwnQuotesTableTableTableManager get ownQuotesTable =>
      $$OwnQuotesTableTableTableManager(_db, _db.ownQuotesTable);
  $$CollectionsOwnQuotesTableTableTableManager get collectionsOwnQuotesTable =>
      $$CollectionsOwnQuotesTableTableTableManager(
        _db,
        _db.collectionsOwnQuotesTable,
      );
  $$CollectionsHistoryQuotesTableTableManager get collectionsHistoryQuotes =>
      $$CollectionsHistoryQuotesTableTableManager(
        _db,
        _db.collectionsHistoryQuotes,
      );
  $$CollectionsSearchQuotesTableTableManager get collectionsSearchQuotes =>
      $$CollectionsSearchQuotesTableTableManager(
        _db,
        _db.collectionsSearchQuotes,
      );
}
