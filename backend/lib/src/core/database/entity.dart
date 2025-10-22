// import 'dart:io';

// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import '../../app/model/application_config.dart';

// part 'database.g.dart';
// part 'database.dart';

// class Users extends Table {
//   IntColumn get id => integer().named('id').autoIncrement()();
//   IntColumn get buildingId =>
//       integer().named('building_id').references(Buildings, #id)();
//   IntColumn get roomId => integer().named('room_id').references(Rooms, #id)();
//   TextColumn get name => text().named('name')();
//   TextColumn get email => text().named('email')();
//   TextColumn get phone => text().named('phone')();
//   TextColumn get photoUrl => text().named('photo_url')();
//   TextColumn get role => text().named('role')();
// }

// class Buildings extends Table {
//   IntColumn get id => integer().named('id').autoIncrement()();
//   TextColumn get name => text().named('name')();
//   TextColumn get address => text().named('address')();
//   IntColumn get number => integer().named('number')();
//   RealColumn get lat => real().named('lat')();
//   RealColumn get long => real().named('long')();
// }

// class Rooms extends Table {
//   IntColumn get id => integer().named('id').autoIncrement()();
//   IntColumn get buildingId =>
//       integer().named('building_id').references(Buildings, #id)();
//   IntColumn get floor => integer().named('floor')();
//   IntColumn get number => integer().named('number')();
//   BoolColumn get isOccupied => boolean().named('is_occupied')();
// }
