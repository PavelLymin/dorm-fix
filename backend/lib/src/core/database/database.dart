import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';
part 'entity.dart';

@DriftDatabase(tables: [Users, Buildings, Rooms])
class AppDatabase extends _$AppDatabase {
  AppDatabase._(super.e);

  static AppDatabase? instance;

  factory AppDatabase({required String path}) =>
      instance ?? AppDatabase._(_openConnection(path: path));

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection({required String path}) {
    return NativeDatabase(File(path));
  }

  @override
  Future<void> close() {
    instance?.close();
    return super.close();
  }
}
