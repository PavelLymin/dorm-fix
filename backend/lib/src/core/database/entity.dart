part of 'database.dart';

class Users extends Table {
  TextColumn get uid => text().named('uid')();
  TextColumn get displayName => text().nullable().named('display_name')();
  TextColumn get email => text().nullable().named('email')();
  TextColumn get phoneNumber => text().nullable().named('phone_number')();
  TextColumn get photoURL => text().nullable().named('photo_url')();
  TextColumn get role => text().named('role')();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class Students extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get uid => text().named('uid').references(Users, #uid)();
  IntColumn get dormitoryId =>
      integer().named('dormitory_id').references(Dormitories, #id)();
  IntColumn get roomId => integer().named('room_id').references(Rooms, #id)();
}

class Masters extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get uid => text().named('uid').references(Users, #uid)();
  IntColumn get specializationId =>
      integer().named('specialization_id').references(Specializations, #id)();
  IntColumn get dormitoryId =>
      integer().named('dormitory_id').references(Dormitories, #id)();
  RealColumn get rating => real().named('rating').withDefault(Constant(0.0))();
}

class Dormitories extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get name => text().named('name')();
  TextColumn get address => text().named('address')();
  IntColumn get number => integer().named('number')();
  RealColumn get lat => real().named('lat')();
  RealColumn get long => real().named('long')();
}

class Rooms extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  IntColumn get dormitoryId =>
      integer().named('dormitory_id').references(Dormitories, #id)();
  IntColumn get floor => integer().named('floor')();
  IntColumn get number => integer().named('number')();
  BoolColumn get isOccupied => boolean().named('is_occupied')();
}

class Requests extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  IntColumn get uid => integer().named('uid').references(Users, #uid)();
  TextColumn get category => text().named('category')();
  TextColumn get description => text().named('description')();
  TextColumn get priority => text().named('priority')();
  TextColumn get status => text().named('status')();
  BoolColumn get studentAbsent => boolean().named('student_absent')();
  DateTimeColumn get scheduleTime => dateTime().named('schedule_time')();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class Assignments extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  IntColumn get uid => integer().named('uid').references(Users, #uid)();
  IntColumn get requestId =>
      integer().named('request_id').references(Requests, #id)();
  DateTimeColumn get createdAt =>
      dateTime().named('created_at').withDefault(currentDateAndTime)();
}

class Specializations extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get description => text().named('description')();
  TextColumn get photoUrl => text().named('photo_url')();
}
