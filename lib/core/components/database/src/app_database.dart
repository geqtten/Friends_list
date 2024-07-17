import 'package:drift/drift.dart';
import 'package:friends_list/core/components/database/database.dart';
import 'package:friends_list/core/components/database/src/tables/friends_table.dart';
import 'package:friends_list/core/components/database/src/tables/users_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Friends, Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? createExecutor());

  @override
  int get schemaVersion => 1;
}
