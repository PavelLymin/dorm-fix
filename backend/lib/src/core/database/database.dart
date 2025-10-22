// part of 'entity.dart';

// @DriftDatabase(tables: [Users, Buildings, Rooms])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase._(super.e);

//   static AppDatabase? instance;

//   factory AppDatabase() => instance ?? AppDatabase._(_openConnection());

//   @override
//   int get schemaVersion => 1;

//   static QueryExecutor _openConnection() {
//     final path = Config.databasePath;
//     return NativeDatabase(File(path));
//   }

//   @override
//   Future<void> close() {
//     instance?.close();
//     instance = null;
//     return super.close();
//   }
// }
