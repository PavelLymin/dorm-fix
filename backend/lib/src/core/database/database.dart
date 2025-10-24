import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';
part 'entity.dart';

@DriftDatabase(tables: [Students, Buildings, Rooms])
class Database extends _$AppDatabase {
  Database.lazy({
    required File file,
    bool logStatements = false,
    bool dropDatabase = false,
  }) : super(
         LazyDatabase(
           () => _opener(
             file: file,
             logStatements: logStatements,
             dropDatabase: dropDatabase,
           ),
         ),
       );

  static Future<QueryExecutor> _opener({
    required File file,
    bool logStatements = false,
    bool dropDatabase = false,
  }) async {
    if (dropDatabase && await file.exists()) {
      await file.delete();
    }

    return NativeDatabase.createInBackground(
      file,
      logStatements: logStatements,
    );
  }

  @override
  int get schemaVersion => 1;
}
