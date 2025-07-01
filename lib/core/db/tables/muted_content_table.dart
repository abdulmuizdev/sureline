import 'package:drift/drift.dart';

class MutedContentTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isWithAuthorMuted =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get isWithoutAuthorMuted =>
      boolean().withDefault(const Constant(false))();
}
