part of 'database.dart';

class DateTimeConverter extends TypeConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromSql(String fromDb) => DateTime.parse(fromDb);

  @override
  String toSql(DateTime value) => value.toLocal().toString();
}

class Users extends Table {
  TextColumn get uid => text().named('uid')();
  TextColumn get displayName => text().nullable().named('display_name')();
  TextColumn get email => text().nullable().named('email')();
  TextColumn get phoneNumber => text().nullable().named('phone_number')();
  TextColumn get photoURL => text().nullable().named('photo_url')();
  TextColumn get role => text().named('role')();
  TextColumn get createdAt => text()
      .named('created_at')
      .map(const DateTimeConverter())
      .withDefault(currentDateAndTime.datetime)();
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
  TextColumn get number => text().named('number')();
  BoolColumn get isOccupied => boolean().named('is_occupied')();
}

class Requests extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get uid => text().named('uid').references(Users, #uid)();
  IntColumn get specializationId =>
      integer().named('specialization_id').references(Specializations, #id)();
  TextColumn get description => text().named('description')();
  TextColumn get priority => text().named('priority')();
  TextColumn get status => text().named('status')();
  BoolColumn get studentAbsent => boolean().named('student_absent')();
  TextColumn get date => text().map(const DateTimeConverter()).named('date')();
  IntColumn get startTime => integer().named('start_time')();
  IntColumn get endTime => integer().named('end_time')();
  TextColumn get createdAt => text()
      .named('created_at')
      .map(const DateTimeConverter())
      .withDefault(currentDateAndTime.datetime)();
}

class Problems extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  IntColumn get requestId =>
      integer().named('request_id').references(Requests, #id)();
  TextColumn get photoPath => text().named('photo_path')();
}

class Assignments extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();
  TextColumn get uid => text().named('uid').references(Users, #uid)();
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
