import 'package:drift/drift.dart';

class Friends extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get lastName => text()();
}
