// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoURLMeta = const VerificationMeta(
    'photoURL',
  );
  @override
  late final GeneratedColumn<String> photoURL = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
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
  List<GeneratedColumn> get $columns => [
    uid,
    displayName,
    email,
    phoneNumber,
    photoURL,
    role,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoURLMeta,
        photoURL.isAcceptableOrUnknown(data['photo_url']!, _photoURLMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
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
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      photoURL: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final String role;
  final DateTime createdAt;
  const User({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    required this.role,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || photoURL != null) {
      map['photo_url'] = Variable<String>(photoURL);
    }
    map['role'] = Variable<String>(role);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      uid: Value(uid),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      photoURL: photoURL == null && nullToAbsent
          ? const Value.absent()
          : Value(photoURL),
      role: Value(role),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      uid: serializer.fromJson<String>(json['uid']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      email: serializer.fromJson<String?>(json['email']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      photoURL: serializer.fromJson<String?>(json['photoURL']),
      role: serializer.fromJson<String>(json['role']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'displayName': serializer.toJson<String?>(displayName),
      'email': serializer.toJson<String?>(email),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'photoURL': serializer.toJson<String?>(photoURL),
      'role': serializer.toJson<String>(role),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    String? uid,
    Value<String?> displayName = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    Value<String?> photoURL = const Value.absent(),
    String? role,
    DateTime? createdAt,
  }) => User(
    uid: uid ?? this.uid,
    displayName: displayName.present ? displayName.value : this.displayName,
    email: email.present ? email.value : this.email,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    photoURL: photoURL.present ? photoURL.value : this.photoURL,
    role: role ?? this.role,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      uid: data.uid.present ? data.uid.value : this.uid,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      email: data.email.present ? data.email.value : this.email,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      photoURL: data.photoURL.present ? data.photoURL.value : this.photoURL,
      role: data.role.present ? data.role.value : this.role,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('uid: $uid, ')
          ..write('displayName: $displayName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('photoURL: $photoURL, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uid,
    displayName,
    email,
    phoneNumber,
    photoURL,
    role,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.uid == this.uid &&
          other.displayName == this.displayName &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.photoURL == this.photoURL &&
          other.role == this.role &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> uid;
  final Value<String?> displayName;
  final Value<String?> email;
  final Value<String?> phoneNumber;
  final Value<String?> photoURL;
  final Value<String> role;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.uid = const Value.absent(),
    this.displayName = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.photoURL = const Value.absent(),
    this.role = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String uid,
    this.displayName = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.photoURL = const Value.absent(),
    required String role,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uid = Value(uid),
       role = Value(role);
  static Insertable<User> custom({
    Expression<String>? uid,
    Expression<String>? displayName,
    Expression<String>? email,
    Expression<String>? phoneNumber,
    Expression<String>? photoURL,
    Expression<String>? role,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (displayName != null) 'display_name': displayName,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (photoURL != null) 'photo_url': photoURL,
      if (role != null) 'role': role,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? uid,
    Value<String?>? displayName,
    Value<String?>? email,
    Value<String?>? phoneNumber,
    Value<String?>? photoURL,
    Value<String>? role,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (photoURL.present) {
      map['photo_url'] = Variable<String>(photoURL.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('uid: $uid, ')
          ..write('displayName: $displayName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('photoURL: $photoURL, ')
          ..write('role: $role, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DormitoriesTable extends Dormitories
    with TableInfo<$DormitoriesTable, Dormitory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DormitoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longMeta = const VerificationMeta('long');
  @override
  late final GeneratedColumn<double> long = GeneratedColumn<double>(
    'long',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, address, number, lat, long];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dormitories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dormitory> instance, {
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
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('long')) {
      context.handle(
        _longMeta,
        long.isAcceptableOrUnknown(data['long']!, _longMeta),
      );
    } else if (isInserting) {
      context.missing(_longMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dormitory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dormitory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      long: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}long'],
      )!,
    );
  }

  @override
  $DormitoriesTable createAlias(String alias) {
    return $DormitoriesTable(attachedDatabase, alias);
  }
}

class Dormitory extends DataClass implements Insertable<Dormitory> {
  final int id;
  final String name;
  final String address;
  final int number;
  final double lat;
  final double long;
  const Dormitory({
    required this.id,
    required this.name,
    required this.address,
    required this.number,
    required this.lat,
    required this.long,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['number'] = Variable<int>(number);
    map['lat'] = Variable<double>(lat);
    map['long'] = Variable<double>(long);
    return map;
  }

  DormitoriesCompanion toCompanion(bool nullToAbsent) {
    return DormitoriesCompanion(
      id: Value(id),
      name: Value(name),
      address: Value(address),
      number: Value(number),
      lat: Value(lat),
      long: Value(long),
    );
  }

  factory Dormitory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dormitory(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      number: serializer.fromJson<int>(json['number']),
      lat: serializer.fromJson<double>(json['lat']),
      long: serializer.fromJson<double>(json['long']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'number': serializer.toJson<int>(number),
      'lat': serializer.toJson<double>(lat),
      'long': serializer.toJson<double>(long),
    };
  }

  Dormitory copyWith({
    int? id,
    String? name,
    String? address,
    int? number,
    double? lat,
    double? long,
  }) => Dormitory(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    number: number ?? this.number,
    lat: lat ?? this.lat,
    long: long ?? this.long,
  );
  Dormitory copyWithCompanion(DormitoriesCompanion data) {
    return Dormitory(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      number: data.number.present ? data.number.value : this.number,
      lat: data.lat.present ? data.lat.value : this.lat,
      long: data.long.present ? data.long.value : this.long,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dormitory(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('number: $number, ')
          ..write('lat: $lat, ')
          ..write('long: $long')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address, number, lat, long);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dormitory &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.number == this.number &&
          other.lat == this.lat &&
          other.long == this.long);
}

class DormitoriesCompanion extends UpdateCompanion<Dormitory> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> address;
  final Value<int> number;
  final Value<double> lat;
  final Value<double> long;
  const DormitoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.number = const Value.absent(),
    this.lat = const Value.absent(),
    this.long = const Value.absent(),
  });
  DormitoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String address,
    required int number,
    required double lat,
    required double long,
  }) : name = Value(name),
       address = Value(address),
       number = Value(number),
       lat = Value(lat),
       long = Value(long);
  static Insertable<Dormitory> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<int>? number,
    Expression<double>? lat,
    Expression<double>? long,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (number != null) 'number': number,
      if (lat != null) 'lat': lat,
      if (long != null) 'long': long,
    });
  }

  DormitoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? address,
    Value<int>? number,
    Value<double>? lat,
    Value<double>? long,
  }) {
    return DormitoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      number: number ?? this.number,
      lat: lat ?? this.lat,
      long: long ?? this.long,
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
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (long.present) {
      map['long'] = Variable<double>(long.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DormitoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('number: $number, ')
          ..write('lat: $lat, ')
          ..write('long: $long')
          ..write(')'))
        .toString();
  }
}

class $RoomsTable extends Rooms with TableInfo<$RoomsTable, Room> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoomsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dormitoryIdMeta = const VerificationMeta(
    'dormitoryId',
  );
  @override
  late final GeneratedColumn<int> dormitoryId = GeneratedColumn<int>(
    'dormitory_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dormitories (id)',
    ),
  );
  static const VerificationMeta _floorMeta = const VerificationMeta('floor');
  @override
  late final GeneratedColumn<int> floor = GeneratedColumn<int>(
    'floor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOccupiedMeta = const VerificationMeta(
    'isOccupied',
  );
  @override
  late final GeneratedColumn<bool> isOccupied = GeneratedColumn<bool>(
    'is_occupied',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_occupied" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dormitoryId,
    floor,
    number,
    isOccupied,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rooms';
  @override
  VerificationContext validateIntegrity(
    Insertable<Room> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dormitory_id')) {
      context.handle(
        _dormitoryIdMeta,
        dormitoryId.isAcceptableOrUnknown(
          data['dormitory_id']!,
          _dormitoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dormitoryIdMeta);
    }
    if (data.containsKey('floor')) {
      context.handle(
        _floorMeta,
        floor.isAcceptableOrUnknown(data['floor']!, _floorMeta),
      );
    } else if (isInserting) {
      context.missing(_floorMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('is_occupied')) {
      context.handle(
        _isOccupiedMeta,
        isOccupied.isAcceptableOrUnknown(data['is_occupied']!, _isOccupiedMeta),
      );
    } else if (isInserting) {
      context.missing(_isOccupiedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Room map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Room(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dormitoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dormitory_id'],
      )!,
      floor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}floor'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      isOccupied: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_occupied'],
      )!,
    );
  }

  @override
  $RoomsTable createAlias(String alias) {
    return $RoomsTable(attachedDatabase, alias);
  }
}

class Room extends DataClass implements Insertable<Room> {
  final int id;
  final int dormitoryId;
  final int floor;
  final int number;
  final bool isOccupied;
  const Room({
    required this.id,
    required this.dormitoryId,
    required this.floor,
    required this.number,
    required this.isOccupied,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dormitory_id'] = Variable<int>(dormitoryId);
    map['floor'] = Variable<int>(floor);
    map['number'] = Variable<int>(number);
    map['is_occupied'] = Variable<bool>(isOccupied);
    return map;
  }

  RoomsCompanion toCompanion(bool nullToAbsent) {
    return RoomsCompanion(
      id: Value(id),
      dormitoryId: Value(dormitoryId),
      floor: Value(floor),
      number: Value(number),
      isOccupied: Value(isOccupied),
    );
  }

  factory Room.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Room(
      id: serializer.fromJson<int>(json['id']),
      dormitoryId: serializer.fromJson<int>(json['dormitoryId']),
      floor: serializer.fromJson<int>(json['floor']),
      number: serializer.fromJson<int>(json['number']),
      isOccupied: serializer.fromJson<bool>(json['isOccupied']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dormitoryId': serializer.toJson<int>(dormitoryId),
      'floor': serializer.toJson<int>(floor),
      'number': serializer.toJson<int>(number),
      'isOccupied': serializer.toJson<bool>(isOccupied),
    };
  }

  Room copyWith({
    int? id,
    int? dormitoryId,
    int? floor,
    int? number,
    bool? isOccupied,
  }) => Room(
    id: id ?? this.id,
    dormitoryId: dormitoryId ?? this.dormitoryId,
    floor: floor ?? this.floor,
    number: number ?? this.number,
    isOccupied: isOccupied ?? this.isOccupied,
  );
  Room copyWithCompanion(RoomsCompanion data) {
    return Room(
      id: data.id.present ? data.id.value : this.id,
      dormitoryId: data.dormitoryId.present
          ? data.dormitoryId.value
          : this.dormitoryId,
      floor: data.floor.present ? data.floor.value : this.floor,
      number: data.number.present ? data.number.value : this.number,
      isOccupied: data.isOccupied.present
          ? data.isOccupied.value
          : this.isOccupied,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Room(')
          ..write('id: $id, ')
          ..write('dormitoryId: $dormitoryId, ')
          ..write('floor: $floor, ')
          ..write('number: $number, ')
          ..write('isOccupied: $isOccupied')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dormitoryId, floor, number, isOccupied);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Room &&
          other.id == this.id &&
          other.dormitoryId == this.dormitoryId &&
          other.floor == this.floor &&
          other.number == this.number &&
          other.isOccupied == this.isOccupied);
}

class RoomsCompanion extends UpdateCompanion<Room> {
  final Value<int> id;
  final Value<int> dormitoryId;
  final Value<int> floor;
  final Value<int> number;
  final Value<bool> isOccupied;
  const RoomsCompanion({
    this.id = const Value.absent(),
    this.dormitoryId = const Value.absent(),
    this.floor = const Value.absent(),
    this.number = const Value.absent(),
    this.isOccupied = const Value.absent(),
  });
  RoomsCompanion.insert({
    this.id = const Value.absent(),
    required int dormitoryId,
    required int floor,
    required int number,
    required bool isOccupied,
  }) : dormitoryId = Value(dormitoryId),
       floor = Value(floor),
       number = Value(number),
       isOccupied = Value(isOccupied);
  static Insertable<Room> custom({
    Expression<int>? id,
    Expression<int>? dormitoryId,
    Expression<int>? floor,
    Expression<int>? number,
    Expression<bool>? isOccupied,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dormitoryId != null) 'dormitory_id': dormitoryId,
      if (floor != null) 'floor': floor,
      if (number != null) 'number': number,
      if (isOccupied != null) 'is_occupied': isOccupied,
    });
  }

  RoomsCompanion copyWith({
    Value<int>? id,
    Value<int>? dormitoryId,
    Value<int>? floor,
    Value<int>? number,
    Value<bool>? isOccupied,
  }) {
    return RoomsCompanion(
      id: id ?? this.id,
      dormitoryId: dormitoryId ?? this.dormitoryId,
      floor: floor ?? this.floor,
      number: number ?? this.number,
      isOccupied: isOccupied ?? this.isOccupied,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dormitoryId.present) {
      map['dormitory_id'] = Variable<int>(dormitoryId.value);
    }
    if (floor.present) {
      map['floor'] = Variable<int>(floor.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (isOccupied.present) {
      map['is_occupied'] = Variable<bool>(isOccupied.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoomsCompanion(')
          ..write('id: $id, ')
          ..write('dormitoryId: $dormitoryId, ')
          ..write('floor: $floor, ')
          ..write('number: $number, ')
          ..write('isOccupied: $isOccupied')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (uid)',
    ),
  );
  static const VerificationMeta _dormitoryIdMeta = const VerificationMeta(
    'dormitoryId',
  );
  @override
  late final GeneratedColumn<int> dormitoryId = GeneratedColumn<int>(
    'dormitory_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dormitories (id)',
    ),
  );
  static const VerificationMeta _roomIdMeta = const VerificationMeta('roomId');
  @override
  late final GeneratedColumn<int> roomId = GeneratedColumn<int>(
    'room_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rooms (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, uid, dormitoryId, roomId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(
    Insertable<Student> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('dormitory_id')) {
      context.handle(
        _dormitoryIdMeta,
        dormitoryId.isAcceptableOrUnknown(
          data['dormitory_id']!,
          _dormitoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dormitoryIdMeta);
    }
    if (data.containsKey('room_id')) {
      context.handle(
        _roomIdMeta,
        roomId.isAcceptableOrUnknown(data['room_id']!, _roomIdMeta),
      );
    } else if (isInserting) {
      context.missing(_roomIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      dormitoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dormitory_id'],
      )!,
      roomId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}room_id'],
      )!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
  final int id;
  final String uid;
  final int dormitoryId;
  final int roomId;
  const Student({
    required this.id,
    required this.uid,
    required this.dormitoryId,
    required this.roomId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid'] = Variable<String>(uid);
    map['dormitory_id'] = Variable<int>(dormitoryId);
    map['room_id'] = Variable<int>(roomId);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      uid: Value(uid),
      dormitoryId: Value(dormitoryId),
      roomId: Value(roomId),
    );
  }

  factory Student.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      dormitoryId: serializer.fromJson<int>(json['dormitoryId']),
      roomId: serializer.fromJson<int>(json['roomId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<String>(uid),
      'dormitoryId': serializer.toJson<int>(dormitoryId),
      'roomId': serializer.toJson<int>(roomId),
    };
  }

  Student copyWith({int? id, String? uid, int? dormitoryId, int? roomId}) =>
      Student(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        dormitoryId: dormitoryId ?? this.dormitoryId,
        roomId: roomId ?? this.roomId,
      );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      dormitoryId: data.dormitoryId.present
          ? data.dormitoryId.value
          : this.dormitoryId,
      roomId: data.roomId.present ? data.roomId.value : this.roomId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('dormitoryId: $dormitoryId, ')
          ..write('roomId: $roomId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uid, dormitoryId, roomId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.dormitoryId == this.dormitoryId &&
          other.roomId == this.roomId);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<int> id;
  final Value<String> uid;
  final Value<int> dormitoryId;
  final Value<int> roomId;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.dormitoryId = const Value.absent(),
    this.roomId = const Value.absent(),
  });
  StudentsCompanion.insert({
    this.id = const Value.absent(),
    required String uid,
    required int dormitoryId,
    required int roomId,
  }) : uid = Value(uid),
       dormitoryId = Value(dormitoryId),
       roomId = Value(roomId);
  static Insertable<Student> custom({
    Expression<int>? id,
    Expression<String>? uid,
    Expression<int>? dormitoryId,
    Expression<int>? roomId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (dormitoryId != null) 'dormitory_id': dormitoryId,
      if (roomId != null) 'room_id': roomId,
    });
  }

  StudentsCompanion copyWith({
    Value<int>? id,
    Value<String>? uid,
    Value<int>? dormitoryId,
    Value<int>? roomId,
  }) {
    return StudentsCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      dormitoryId: dormitoryId ?? this.dormitoryId,
      roomId: roomId ?? this.roomId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (dormitoryId.present) {
      map['dormitory_id'] = Variable<int>(dormitoryId.value);
    }
    if (roomId.present) {
      map['room_id'] = Variable<int>(roomId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('dormitoryId: $dormitoryId, ')
          ..write('roomId: $roomId')
          ..write(')'))
        .toString();
  }
}

class $SpecializationsTable extends Specializations
    with TableInfo<$SpecializationsTable, Specialization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpecializationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, description, photoUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'specializations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Specialization> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_photoUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Specialization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Specialization(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      )!,
    );
  }

  @override
  $SpecializationsTable createAlias(String alias) {
    return $SpecializationsTable(attachedDatabase, alias);
  }
}

class Specialization extends DataClass implements Insertable<Specialization> {
  final int id;
  final String title;
  final String description;
  final String photoUrl;
  const Specialization({
    required this.id,
    required this.title,
    required this.description,
    required this.photoUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['photo_url'] = Variable<String>(photoUrl);
    return map;
  }

  SpecializationsCompanion toCompanion(bool nullToAbsent) {
    return SpecializationsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      photoUrl: Value(photoUrl),
    );
  }

  factory Specialization.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Specialization(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      photoUrl: serializer.fromJson<String>(json['photoUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'photoUrl': serializer.toJson<String>(photoUrl),
    };
  }

  Specialization copyWith({
    int? id,
    String? title,
    String? description,
    String? photoUrl,
  }) => Specialization(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    photoUrl: photoUrl ?? this.photoUrl,
  );
  Specialization copyWithCompanion(SpecializationsCompanion data) {
    return Specialization(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Specialization(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('photoUrl: $photoUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, photoUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Specialization &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.photoUrl == this.photoUrl);
}

class SpecializationsCompanion extends UpdateCompanion<Specialization> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> photoUrl;
  const SpecializationsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.photoUrl = const Value.absent(),
  });
  SpecializationsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    required String photoUrl,
  }) : title = Value(title),
       description = Value(description),
       photoUrl = Value(photoUrl);
  static Insertable<Specialization> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? photoUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (photoUrl != null) 'photo_url': photoUrl,
    });
  }

  SpecializationsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? photoUrl,
  }) {
    return SpecializationsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpecializationsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('photoUrl: $photoUrl')
          ..write(')'))
        .toString();
  }
}

class $MastersTable extends Masters with TableInfo<$MastersTable, Master> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MastersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
    'uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (uid)',
    ),
  );
  static const VerificationMeta _specializationIdMeta = const VerificationMeta(
    'specializationId',
  );
  @override
  late final GeneratedColumn<int> specializationId = GeneratedColumn<int>(
    'specialization_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES specializations (id)',
    ),
  );
  static const VerificationMeta _dormitoryIdMeta = const VerificationMeta(
    'dormitoryId',
  );
  @override
  late final GeneratedColumn<int> dormitoryId = GeneratedColumn<int>(
    'dormitory_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES dormitories (id)',
    ),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uid,
    specializationId,
    dormitoryId,
    rating,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'masters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Master> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
        _uidMeta,
        uid.isAcceptableOrUnknown(data['uid']!, _uidMeta),
      );
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('specialization_id')) {
      context.handle(
        _specializationIdMeta,
        specializationId.isAcceptableOrUnknown(
          data['specialization_id']!,
          _specializationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_specializationIdMeta);
    }
    if (data.containsKey('dormitory_id')) {
      context.handle(
        _dormitoryIdMeta,
        dormitoryId.isAcceptableOrUnknown(
          data['dormitory_id']!,
          _dormitoryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dormitoryIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Master map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Master(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uid'],
      )!,
      specializationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}specialization_id'],
      )!,
      dormitoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dormitory_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      )!,
    );
  }

  @override
  $MastersTable createAlias(String alias) {
    return $MastersTable(attachedDatabase, alias);
  }
}

class Master extends DataClass implements Insertable<Master> {
  final int id;
  final String uid;
  final int specializationId;
  final int dormitoryId;
  final double rating;
  const Master({
    required this.id,
    required this.uid,
    required this.specializationId,
    required this.dormitoryId,
    required this.rating,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid'] = Variable<String>(uid);
    map['specialization_id'] = Variable<int>(specializationId);
    map['dormitory_id'] = Variable<int>(dormitoryId);
    map['rating'] = Variable<double>(rating);
    return map;
  }

  MastersCompanion toCompanion(bool nullToAbsent) {
    return MastersCompanion(
      id: Value(id),
      uid: Value(uid),
      specializationId: Value(specializationId),
      dormitoryId: Value(dormitoryId),
      rating: Value(rating),
    );
  }

  factory Master.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Master(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      specializationId: serializer.fromJson<int>(json['specializationId']),
      dormitoryId: serializer.fromJson<int>(json['dormitoryId']),
      rating: serializer.fromJson<double>(json['rating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<String>(uid),
      'specializationId': serializer.toJson<int>(specializationId),
      'dormitoryId': serializer.toJson<int>(dormitoryId),
      'rating': serializer.toJson<double>(rating),
    };
  }

  Master copyWith({
    int? id,
    String? uid,
    int? specializationId,
    int? dormitoryId,
    double? rating,
  }) => Master(
    id: id ?? this.id,
    uid: uid ?? this.uid,
    specializationId: specializationId ?? this.specializationId,
    dormitoryId: dormitoryId ?? this.dormitoryId,
    rating: rating ?? this.rating,
  );
  Master copyWithCompanion(MastersCompanion data) {
    return Master(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      specializationId: data.specializationId.present
          ? data.specializationId.value
          : this.specializationId,
      dormitoryId: data.dormitoryId.present
          ? data.dormitoryId.value
          : this.dormitoryId,
      rating: data.rating.present ? data.rating.value : this.rating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Master(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('specializationId: $specializationId, ')
          ..write('dormitoryId: $dormitoryId, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uid, specializationId, dormitoryId, rating);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Master &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.specializationId == this.specializationId &&
          other.dormitoryId == this.dormitoryId &&
          other.rating == this.rating);
}

class MastersCompanion extends UpdateCompanion<Master> {
  final Value<int> id;
  final Value<String> uid;
  final Value<int> specializationId;
  final Value<int> dormitoryId;
  final Value<double> rating;
  const MastersCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.specializationId = const Value.absent(),
    this.dormitoryId = const Value.absent(),
    this.rating = const Value.absent(),
  });
  MastersCompanion.insert({
    this.id = const Value.absent(),
    required String uid,
    required int specializationId,
    required int dormitoryId,
    this.rating = const Value.absent(),
  }) : uid = Value(uid),
       specializationId = Value(specializationId),
       dormitoryId = Value(dormitoryId);
  static Insertable<Master> custom({
    Expression<int>? id,
    Expression<String>? uid,
    Expression<int>? specializationId,
    Expression<int>? dormitoryId,
    Expression<double>? rating,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (specializationId != null) 'specialization_id': specializationId,
      if (dormitoryId != null) 'dormitory_id': dormitoryId,
      if (rating != null) 'rating': rating,
    });
  }

  MastersCompanion copyWith({
    Value<int>? id,
    Value<String>? uid,
    Value<int>? specializationId,
    Value<int>? dormitoryId,
    Value<double>? rating,
  }) {
    return MastersCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      specializationId: specializationId ?? this.specializationId,
      dormitoryId: dormitoryId ?? this.dormitoryId,
      rating: rating ?? this.rating,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (specializationId.present) {
      map['specialization_id'] = Variable<int>(specializationId.value);
    }
    if (dormitoryId.present) {
      map['dormitory_id'] = Variable<int>(dormitoryId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MastersCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('specializationId: $specializationId, ')
          ..write('dormitoryId: $dormitoryId, ')
          ..write('rating: $rating')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $DormitoriesTable dormitories = $DormitoriesTable(this);
  late final $RoomsTable rooms = $RoomsTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $SpecializationsTable specializations = $SpecializationsTable(
    this,
  );
  late final $MastersTable masters = $MastersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    dormitories,
    rooms,
    students,
    specializations,
    masters,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String uid,
      Value<String?> displayName,
      Value<String?> email,
      Value<String?> phoneNumber,
      Value<String?> photoURL,
      required String role,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> uid,
      Value<String?> displayName,
      Value<String?> email,
      Value<String?> phoneNumber,
      Value<String?> photoURL,
      Value<String> role,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$Database, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$StudentsTable, List<Student>> _studentsRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.students,
    aliasName: $_aliasNameGenerator(db.users.uid, db.students.uid),
  );

  $$StudentsTableProcessedTableManager get studentsRefs {
    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.uid.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_studentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MastersTable, List<Master>> _mastersRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.masters,
    aliasName: $_aliasNameGenerator(db.users.uid, db.masters.uid),
  );

  $$MastersTableProcessedTableManager get mastersRefs {
    final manager = $$MastersTableTableManager(
      $_db,
      $_db.masters,
    ).filter((f) => f.uid.uid.sqlEquals($_itemColumn<String>('uid')!));

    final cache = $_typedResult.readTableOrNull(_mastersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoURL => $composableBuilder(
    column: $table.photoURL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> studentsRefs(
    Expression<bool> Function($$StudentsTableFilterComposer f) f,
  ) {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mastersRefs(
    Expression<bool> Function($$MastersTableFilterComposer f) f,
  ) {
    final $$MastersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.masters,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MastersTableFilterComposer(
            $db: $db,
            $table: $db.masters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
    column: $table.uid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoURL => $composableBuilder(
    column: $table.photoURL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer extends Composer<_$Database, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoURL =>
      $composableBuilder(column: $table.photoURL, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> studentsRefs<T extends Object>(
    Expression<T> Function($$StudentsTableAnnotationComposer a) f,
  ) {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mastersRefs<T extends Object>(
    Expression<T> Function($$MastersTableAnnotationComposer a) f,
  ) {
    final $$MastersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.masters,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MastersTableAnnotationComposer(
            $db: $db,
            $table: $db.masters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$Database,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool studentsRefs, bool mastersRefs})
        > {
  $$UsersTableTableManager(_$Database db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uid = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> photoURL = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                uid: uid,
                displayName: displayName,
                email: email,
                phoneNumber: phoneNumber,
                photoURL: photoURL,
                role: role,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uid,
                Value<String?> displayName = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> photoURL = const Value.absent(),
                required String role,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                uid: uid,
                displayName: displayName,
                email: email,
                phoneNumber: phoneNumber,
                photoURL: photoURL,
                role: role,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({studentsRefs = false, mastersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studentsRefs) db.students,
                if (mastersRefs) db.masters,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studentsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Student>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._studentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).studentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.uid == item.uid),
                      typedResults: items,
                    ),
                  if (mastersRefs)
                    await $_getPrefetchedData<User, $UsersTable, Master>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences._mastersRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UsersTableReferences(db, table, p0).mastersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.uid == item.uid),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool studentsRefs, bool mastersRefs})
    >;
typedef $$DormitoriesTableCreateCompanionBuilder =
    DormitoriesCompanion Function({
      Value<int> id,
      required String name,
      required String address,
      required int number,
      required double lat,
      required double long,
    });
typedef $$DormitoriesTableUpdateCompanionBuilder =
    DormitoriesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> address,
      Value<int> number,
      Value<double> lat,
      Value<double> long,
    });

final class $$DormitoriesTableReferences
    extends BaseReferences<_$Database, $DormitoriesTable, Dormitory> {
  $$DormitoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RoomsTable, List<Room>> _roomsRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.rooms,
    aliasName: $_aliasNameGenerator(db.dormitories.id, db.rooms.dormitoryId),
  );

  $$RoomsTableProcessedTableManager get roomsRefs {
    final manager = $$RoomsTableTableManager(
      $_db,
      $_db.rooms,
    ).filter((f) => f.dormitoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_roomsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StudentsTable, List<Student>> _studentsRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.students,
    aliasName: $_aliasNameGenerator(db.dormitories.id, db.students.dormitoryId),
  );

  $$StudentsTableProcessedTableManager get studentsRefs {
    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.dormitoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MastersTable, List<Master>> _mastersRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.masters,
    aliasName: $_aliasNameGenerator(db.dormitories.id, db.masters.dormitoryId),
  );

  $$MastersTableProcessedTableManager get mastersRefs {
    final manager = $$MastersTableTableManager(
      $_db,
      $_db.masters,
    ).filter((f) => f.dormitoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mastersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DormitoriesTableFilterComposer
    extends Composer<_$Database, $DormitoriesTable> {
  $$DormitoriesTableFilterComposer({
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

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get long => $composableBuilder(
    column: $table.long,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> roomsRefs(
    Expression<bool> Function($$RoomsTableFilterComposer f) f,
  ) {
    final $$RoomsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.dormitoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableFilterComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> studentsRefs(
    Expression<bool> Function($$StudentsTableFilterComposer f) f,
  ) {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.dormitoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mastersRefs(
    Expression<bool> Function($$MastersTableFilterComposer f) f,
  ) {
    final $$MastersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.masters,
      getReferencedColumn: (t) => t.dormitoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MastersTableFilterComposer(
            $db: $db,
            $table: $db.masters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DormitoriesTableOrderingComposer
    extends Composer<_$Database, $DormitoriesTable> {
  $$DormitoriesTableOrderingComposer({
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

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get long => $composableBuilder(
    column: $table.long,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DormitoriesTableAnnotationComposer
    extends Composer<_$Database, $DormitoriesTable> {
  $$DormitoriesTableAnnotationComposer({
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

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get long =>
      $composableBuilder(column: $table.long, builder: (column) => column);

  Expression<T> roomsRefs<T extends Object>(
    Expression<T> Function($$RoomsTableAnnotationComposer a) f,
  ) {
    final $$RoomsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.dormitoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableAnnotationComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> studentsRefs<T extends Object>(
    Expression<T> Function($$StudentsTableAnnotationComposer a) f,
  ) {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.dormitoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mastersRefs<T extends Object>(
    Expression<T> Function($$MastersTableAnnotationComposer a) f,
  ) {
    final $$MastersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.masters,
      getReferencedColumn: (t) => t.dormitoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MastersTableAnnotationComposer(
            $db: $db,
            $table: $db.masters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DormitoriesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $DormitoriesTable,
          Dormitory,
          $$DormitoriesTableFilterComposer,
          $$DormitoriesTableOrderingComposer,
          $$DormitoriesTableAnnotationComposer,
          $$DormitoriesTableCreateCompanionBuilder,
          $$DormitoriesTableUpdateCompanionBuilder,
          (Dormitory, $$DormitoriesTableReferences),
          Dormitory,
          PrefetchHooks Function({
            bool roomsRefs,
            bool studentsRefs,
            bool mastersRefs,
          })
        > {
  $$DormitoriesTableTableManager(_$Database db, $DormitoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DormitoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DormitoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DormitoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> long = const Value.absent(),
              }) => DormitoriesCompanion(
                id: id,
                name: name,
                address: address,
                number: number,
                lat: lat,
                long: long,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String address,
                required int number,
                required double lat,
                required double long,
              }) => DormitoriesCompanion.insert(
                id: id,
                name: name,
                address: address,
                number: number,
                lat: lat,
                long: long,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DormitoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({roomsRefs = false, studentsRefs = false, mastersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (roomsRefs) db.rooms,
                    if (studentsRefs) db.students,
                    if (mastersRefs) db.masters,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (roomsRefs)
                        await $_getPrefetchedData<
                          Dormitory,
                          $DormitoriesTable,
                          Room
                        >(
                          currentTable: table,
                          referencedTable: $$DormitoriesTableReferences
                              ._roomsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DormitoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).roomsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dormitoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (studentsRefs)
                        await $_getPrefetchedData<
                          Dormitory,
                          $DormitoriesTable,
                          Student
                        >(
                          currentTable: table,
                          referencedTable: $$DormitoriesTableReferences
                              ._studentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DormitoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).studentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dormitoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mastersRefs)
                        await $_getPrefetchedData<
                          Dormitory,
                          $DormitoriesTable,
                          Master
                        >(
                          currentTable: table,
                          referencedTable: $$DormitoriesTableReferences
                              ._mastersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DormitoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).mastersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dormitoryId == item.id,
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

typedef $$DormitoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $DormitoriesTable,
      Dormitory,
      $$DormitoriesTableFilterComposer,
      $$DormitoriesTableOrderingComposer,
      $$DormitoriesTableAnnotationComposer,
      $$DormitoriesTableCreateCompanionBuilder,
      $$DormitoriesTableUpdateCompanionBuilder,
      (Dormitory, $$DormitoriesTableReferences),
      Dormitory,
      PrefetchHooks Function({
        bool roomsRefs,
        bool studentsRefs,
        bool mastersRefs,
      })
    >;
typedef $$RoomsTableCreateCompanionBuilder =
    RoomsCompanion Function({
      Value<int> id,
      required int dormitoryId,
      required int floor,
      required int number,
      required bool isOccupied,
    });
typedef $$RoomsTableUpdateCompanionBuilder =
    RoomsCompanion Function({
      Value<int> id,
      Value<int> dormitoryId,
      Value<int> floor,
      Value<int> number,
      Value<bool> isOccupied,
    });

final class $$RoomsTableReferences
    extends BaseReferences<_$Database, $RoomsTable, Room> {
  $$RoomsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DormitoriesTable _dormitoryIdTable(_$Database db) =>
      db.dormitories.createAlias(
        $_aliasNameGenerator(db.rooms.dormitoryId, db.dormitories.id),
      );

  $$DormitoriesTableProcessedTableManager get dormitoryId {
    final $_column = $_itemColumn<int>('dormitory_id')!;

    final manager = $$DormitoriesTableTableManager(
      $_db,
      $_db.dormitories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dormitoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$StudentsTable, List<Student>> _studentsRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.students,
    aliasName: $_aliasNameGenerator(db.rooms.id, db.students.roomId),
  );

  $$StudentsTableProcessedTableManager get studentsRefs {
    final manager = $$StudentsTableTableManager(
      $_db,
      $_db.students,
    ).filter((f) => f.roomId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoomsTableFilterComposer extends Composer<_$Database, $RoomsTable> {
  $$RoomsTableFilterComposer({
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

  ColumnFilters<int> get floor => $composableBuilder(
    column: $table.floor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOccupied => $composableBuilder(
    column: $table.isOccupied,
    builder: (column) => ColumnFilters(column),
  );

  $$DormitoriesTableFilterComposer get dormitoryId {
    final $$DormitoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableFilterComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> studentsRefs(
    Expression<bool> Function($$StudentsTableFilterComposer f) f,
  ) {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.roomId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableFilterComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoomsTableOrderingComposer extends Composer<_$Database, $RoomsTable> {
  $$RoomsTableOrderingComposer({
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

  ColumnOrderings<int> get floor => $composableBuilder(
    column: $table.floor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOccupied => $composableBuilder(
    column: $table.isOccupied,
    builder: (column) => ColumnOrderings(column),
  );

  $$DormitoriesTableOrderingComposer get dormitoryId {
    final $$DormitoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableOrderingComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoomsTableAnnotationComposer extends Composer<_$Database, $RoomsTable> {
  $$RoomsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get floor =>
      $composableBuilder(column: $table.floor, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<bool> get isOccupied => $composableBuilder(
    column: $table.isOccupied,
    builder: (column) => column,
  );

  $$DormitoriesTableAnnotationComposer get dormitoryId {
    final $$DormitoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> studentsRefs<T extends Object>(
    Expression<T> Function($$StudentsTableAnnotationComposer a) f,
  ) {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.students,
      getReferencedColumn: (t) => t.roomId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StudentsTableAnnotationComposer(
            $db: $db,
            $table: $db.students,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoomsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $RoomsTable,
          Room,
          $$RoomsTableFilterComposer,
          $$RoomsTableOrderingComposer,
          $$RoomsTableAnnotationComposer,
          $$RoomsTableCreateCompanionBuilder,
          $$RoomsTableUpdateCompanionBuilder,
          (Room, $$RoomsTableReferences),
          Room,
          PrefetchHooks Function({bool dormitoryId, bool studentsRefs})
        > {
  $$RoomsTableTableManager(_$Database db, $RoomsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoomsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoomsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoomsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dormitoryId = const Value.absent(),
                Value<int> floor = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<bool> isOccupied = const Value.absent(),
              }) => RoomsCompanion(
                id: id,
                dormitoryId: dormitoryId,
                floor: floor,
                number: number,
                isOccupied: isOccupied,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dormitoryId,
                required int floor,
                required int number,
                required bool isOccupied,
              }) => RoomsCompanion.insert(
                id: id,
                dormitoryId: dormitoryId,
                floor: floor,
                number: number,
                isOccupied: isOccupied,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$RoomsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({dormitoryId = false, studentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (studentsRefs) db.students],
              addJoins:
                  <
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
                    if (dormitoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dormitoryId,
                                referencedTable: $$RoomsTableReferences
                                    ._dormitoryIdTable(db),
                                referencedColumn: $$RoomsTableReferences
                                    ._dormitoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studentsRefs)
                    await $_getPrefetchedData<Room, $RoomsTable, Student>(
                      currentTable: table,
                      referencedTable: $$RoomsTableReferences
                          ._studentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RoomsTableReferences(db, table, p0).studentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.roomId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RoomsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $RoomsTable,
      Room,
      $$RoomsTableFilterComposer,
      $$RoomsTableOrderingComposer,
      $$RoomsTableAnnotationComposer,
      $$RoomsTableCreateCompanionBuilder,
      $$RoomsTableUpdateCompanionBuilder,
      (Room, $$RoomsTableReferences),
      Room,
      PrefetchHooks Function({bool dormitoryId, bool studentsRefs})
    >;
typedef $$StudentsTableCreateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      required String uid,
      required int dormitoryId,
      required int roomId,
    });
typedef $$StudentsTableUpdateCompanionBuilder =
    StudentsCompanion Function({
      Value<int> id,
      Value<String> uid,
      Value<int> dormitoryId,
      Value<int> roomId,
    });

final class $$StudentsTableReferences
    extends BaseReferences<_$Database, $StudentsTable, Student> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _uidTable(_$Database db) =>
      db.users.createAlias($_aliasNameGenerator(db.students.uid, db.users.uid));

  $$UsersTableProcessedTableManager get uid {
    final $_column = $_itemColumn<String>('uid')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_uidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DormitoriesTable _dormitoryIdTable(_$Database db) =>
      db.dormitories.createAlias(
        $_aliasNameGenerator(db.students.dormitoryId, db.dormitories.id),
      );

  $$DormitoriesTableProcessedTableManager get dormitoryId {
    final $_column = $_itemColumn<int>('dormitory_id')!;

    final manager = $$DormitoriesTableTableManager(
      $_db,
      $_db.dormitories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dormitoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RoomsTable _roomIdTable(_$Database db) => db.rooms.createAlias(
    $_aliasNameGenerator(db.students.roomId, db.rooms.id),
  );

  $$RoomsTableProcessedTableManager get roomId {
    final $_column = $_itemColumn<int>('room_id')!;

    final manager = $$RoomsTableTableManager(
      $_db,
      $_db.rooms,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roomIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$Database, $StudentsTable> {
  $$StudentsTableFilterComposer({
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

  $$UsersTableFilterComposer get uid {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DormitoriesTableFilterComposer get dormitoryId {
    final $$DormitoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableFilterComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableFilterComposer get roomId {
    final $$RoomsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableFilterComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$Database, $StudentsTable> {
  $$StudentsTableOrderingComposer({
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

  $$UsersTableOrderingComposer get uid {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DormitoriesTableOrderingComposer get dormitoryId {
    final $$DormitoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableOrderingComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableOrderingComposer get roomId {
    final $$RoomsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableOrderingComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$Database, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$UsersTableAnnotationComposer get uid {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DormitoriesTableAnnotationComposer get dormitoryId {
    final $$DormitoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoomsTableAnnotationComposer get roomId {
    final $$RoomsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roomId,
      referencedTable: $db.rooms,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoomsTableAnnotationComposer(
            $db: $db,
            $table: $db.rooms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StudentsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $StudentsTable,
          Student,
          $$StudentsTableFilterComposer,
          $$StudentsTableOrderingComposer,
          $$StudentsTableAnnotationComposer,
          $$StudentsTableCreateCompanionBuilder,
          $$StudentsTableUpdateCompanionBuilder,
          (Student, $$StudentsTableReferences),
          Student,
          PrefetchHooks Function({bool uid, bool dormitoryId, bool roomId})
        > {
  $$StudentsTableTableManager(_$Database db, $StudentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uid = const Value.absent(),
                Value<int> dormitoryId = const Value.absent(),
                Value<int> roomId = const Value.absent(),
              }) => StudentsCompanion(
                id: id,
                uid: uid,
                dormitoryId: dormitoryId,
                roomId: roomId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uid,
                required int dormitoryId,
                required int roomId,
              }) => StudentsCompanion.insert(
                id: id,
                uid: uid,
                dormitoryId: dormitoryId,
                roomId: roomId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StudentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({uid = false, dormitoryId = false, roomId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
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
                        if (uid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.uid,
                                    referencedTable: $$StudentsTableReferences
                                        ._uidTable(db),
                                    referencedColumn: $$StudentsTableReferences
                                        ._uidTable(db)
                                        .uid,
                                  )
                                  as T;
                        }
                        if (dormitoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.dormitoryId,
                                    referencedTable: $$StudentsTableReferences
                                        ._dormitoryIdTable(db),
                                    referencedColumn: $$StudentsTableReferences
                                        ._dormitoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (roomId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.roomId,
                                    referencedTable: $$StudentsTableReferences
                                        ._roomIdTable(db),
                                    referencedColumn: $$StudentsTableReferences
                                        ._roomIdTable(db)
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

typedef $$StudentsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $StudentsTable,
      Student,
      $$StudentsTableFilterComposer,
      $$StudentsTableOrderingComposer,
      $$StudentsTableAnnotationComposer,
      $$StudentsTableCreateCompanionBuilder,
      $$StudentsTableUpdateCompanionBuilder,
      (Student, $$StudentsTableReferences),
      Student,
      PrefetchHooks Function({bool uid, bool dormitoryId, bool roomId})
    >;
typedef $$SpecializationsTableCreateCompanionBuilder =
    SpecializationsCompanion Function({
      Value<int> id,
      required String title,
      required String description,
      required String photoUrl,
    });
typedef $$SpecializationsTableUpdateCompanionBuilder =
    SpecializationsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> description,
      Value<String> photoUrl,
    });

final class $$SpecializationsTableReferences
    extends BaseReferences<_$Database, $SpecializationsTable, Specialization> {
  $$SpecializationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$MastersTable, List<Master>> _mastersRefsTable(
    _$Database db,
  ) => MultiTypedResultKey.fromTable(
    db.masters,
    aliasName: $_aliasNameGenerator(
      db.specializations.id,
      db.masters.specializationId,
    ),
  );

  $$MastersTableProcessedTableManager get mastersRefs {
    final manager = $$MastersTableTableManager(
      $_db,
      $_db.masters,
    ).filter((f) => f.specializationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mastersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SpecializationsTableFilterComposer
    extends Composer<_$Database, $SpecializationsTable> {
  $$SpecializationsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mastersRefs(
    Expression<bool> Function($$MastersTableFilterComposer f) f,
  ) {
    final $$MastersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.masters,
      getReferencedColumn: (t) => t.specializationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MastersTableFilterComposer(
            $db: $db,
            $table: $db.masters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpecializationsTableOrderingComposer
    extends Composer<_$Database, $SpecializationsTable> {
  $$SpecializationsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpecializationsTableAnnotationComposer
    extends Composer<_$Database, $SpecializationsTable> {
  $$SpecializationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  Expression<T> mastersRefs<T extends Object>(
    Expression<T> Function($$MastersTableAnnotationComposer a) f,
  ) {
    final $$MastersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.masters,
      getReferencedColumn: (t) => t.specializationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MastersTableAnnotationComposer(
            $db: $db,
            $table: $db.masters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SpecializationsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $SpecializationsTable,
          Specialization,
          $$SpecializationsTableFilterComposer,
          $$SpecializationsTableOrderingComposer,
          $$SpecializationsTableAnnotationComposer,
          $$SpecializationsTableCreateCompanionBuilder,
          $$SpecializationsTableUpdateCompanionBuilder,
          (Specialization, $$SpecializationsTableReferences),
          Specialization,
          PrefetchHooks Function({bool mastersRefs})
        > {
  $$SpecializationsTableTableManager(_$Database db, $SpecializationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpecializationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpecializationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpecializationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> photoUrl = const Value.absent(),
              }) => SpecializationsCompanion(
                id: id,
                title: title,
                description: description,
                photoUrl: photoUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String description,
                required String photoUrl,
              }) => SpecializationsCompanion.insert(
                id: id,
                title: title,
                description: description,
                photoUrl: photoUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SpecializationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({mastersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (mastersRefs) db.masters],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mastersRefs)
                    await $_getPrefetchedData<
                      Specialization,
                      $SpecializationsTable,
                      Master
                    >(
                      currentTable: table,
                      referencedTable: $$SpecializationsTableReferences
                          ._mastersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SpecializationsTableReferences(
                            db,
                            table,
                            p0,
                          ).mastersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.specializationId == item.id,
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

typedef $$SpecializationsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $SpecializationsTable,
      Specialization,
      $$SpecializationsTableFilterComposer,
      $$SpecializationsTableOrderingComposer,
      $$SpecializationsTableAnnotationComposer,
      $$SpecializationsTableCreateCompanionBuilder,
      $$SpecializationsTableUpdateCompanionBuilder,
      (Specialization, $$SpecializationsTableReferences),
      Specialization,
      PrefetchHooks Function({bool mastersRefs})
    >;
typedef $$MastersTableCreateCompanionBuilder =
    MastersCompanion Function({
      Value<int> id,
      required String uid,
      required int specializationId,
      required int dormitoryId,
      Value<double> rating,
    });
typedef $$MastersTableUpdateCompanionBuilder =
    MastersCompanion Function({
      Value<int> id,
      Value<String> uid,
      Value<int> specializationId,
      Value<int> dormitoryId,
      Value<double> rating,
    });

final class $$MastersTableReferences
    extends BaseReferences<_$Database, $MastersTable, Master> {
  $$MastersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _uidTable(_$Database db) =>
      db.users.createAlias($_aliasNameGenerator(db.masters.uid, db.users.uid));

  $$UsersTableProcessedTableManager get uid {
    final $_column = $_itemColumn<String>('uid')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.uid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_uidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SpecializationsTable _specializationIdTable(_$Database db) =>
      db.specializations.createAlias(
        $_aliasNameGenerator(
          db.masters.specializationId,
          db.specializations.id,
        ),
      );

  $$SpecializationsTableProcessedTableManager get specializationId {
    final $_column = $_itemColumn<int>('specialization_id')!;

    final manager = $$SpecializationsTableTableManager(
      $_db,
      $_db.specializations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_specializationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DormitoriesTable _dormitoryIdTable(_$Database db) =>
      db.dormitories.createAlias(
        $_aliasNameGenerator(db.masters.dormitoryId, db.dormitories.id),
      );

  $$DormitoriesTableProcessedTableManager get dormitoryId {
    final $_column = $_itemColumn<int>('dormitory_id')!;

    final manager = $$DormitoriesTableTableManager(
      $_db,
      $_db.dormitories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dormitoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MastersTableFilterComposer extends Composer<_$Database, $MastersTable> {
  $$MastersTableFilterComposer({
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

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get uid {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpecializationsTableFilterComposer get specializationId {
    final $$SpecializationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.specializationId,
      referencedTable: $db.specializations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpecializationsTableFilterComposer(
            $db: $db,
            $table: $db.specializations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DormitoriesTableFilterComposer get dormitoryId {
    final $$DormitoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableFilterComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MastersTableOrderingComposer
    extends Composer<_$Database, $MastersTable> {
  $$MastersTableOrderingComposer({
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

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get uid {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpecializationsTableOrderingComposer get specializationId {
    final $$SpecializationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.specializationId,
      referencedTable: $db.specializations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpecializationsTableOrderingComposer(
            $db: $db,
            $table: $db.specializations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DormitoriesTableOrderingComposer get dormitoryId {
    final $$DormitoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableOrderingComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MastersTableAnnotationComposer
    extends Composer<_$Database, $MastersTable> {
  $$MastersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  $$UsersTableAnnotationComposer get uid {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.uid,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.uid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SpecializationsTableAnnotationComposer get specializationId {
    final $$SpecializationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.specializationId,
      referencedTable: $db.specializations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SpecializationsTableAnnotationComposer(
            $db: $db,
            $table: $db.specializations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DormitoriesTableAnnotationComposer get dormitoryId {
    final $$DormitoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dormitoryId,
      referencedTable: $db.dormitories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DormitoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.dormitories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MastersTableTableManager
    extends
        RootTableManager<
          _$Database,
          $MastersTable,
          Master,
          $$MastersTableFilterComposer,
          $$MastersTableOrderingComposer,
          $$MastersTableAnnotationComposer,
          $$MastersTableCreateCompanionBuilder,
          $$MastersTableUpdateCompanionBuilder,
          (Master, $$MastersTableReferences),
          Master,
          PrefetchHooks Function({
            bool uid,
            bool specializationId,
            bool dormitoryId,
          })
        > {
  $$MastersTableTableManager(_$Database db, $MastersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MastersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MastersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MastersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uid = const Value.absent(),
                Value<int> specializationId = const Value.absent(),
                Value<int> dormitoryId = const Value.absent(),
                Value<double> rating = const Value.absent(),
              }) => MastersCompanion(
                id: id,
                uid: uid,
                specializationId: specializationId,
                dormitoryId: dormitoryId,
                rating: rating,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uid,
                required int specializationId,
                required int dormitoryId,
                Value<double> rating = const Value.absent(),
              }) => MastersCompanion.insert(
                id: id,
                uid: uid,
                specializationId: specializationId,
                dormitoryId: dormitoryId,
                rating: rating,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MastersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({uid = false, specializationId = false, dormitoryId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
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
                        if (uid) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.uid,
                                    referencedTable: $$MastersTableReferences
                                        ._uidTable(db),
                                    referencedColumn: $$MastersTableReferences
                                        ._uidTable(db)
                                        .uid,
                                  )
                                  as T;
                        }
                        if (specializationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.specializationId,
                                    referencedTable: $$MastersTableReferences
                                        ._specializationIdTable(db),
                                    referencedColumn: $$MastersTableReferences
                                        ._specializationIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (dormitoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.dormitoryId,
                                    referencedTable: $$MastersTableReferences
                                        ._dormitoryIdTable(db),
                                    referencedColumn: $$MastersTableReferences
                                        ._dormitoryIdTable(db)
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

typedef $$MastersTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $MastersTable,
      Master,
      $$MastersTableFilterComposer,
      $$MastersTableOrderingComposer,
      $$MastersTableAnnotationComposer,
      $$MastersTableCreateCompanionBuilder,
      $$MastersTableUpdateCompanionBuilder,
      (Master, $$MastersTableReferences),
      Master,
      PrefetchHooks Function({
        bool uid,
        bool specializationId,
        bool dormitoryId,
      })
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$DormitoriesTableTableManager get dormitories =>
      $$DormitoriesTableTableManager(_db, _db.dormitories);
  $$RoomsTableTableManager get rooms =>
      $$RoomsTableTableManager(_db, _db.rooms);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$SpecializationsTableTableManager get specializations =>
      $$SpecializationsTableTableManager(_db, _db.specializations);
  $$MastersTableTableManager get masters =>
      $$MastersTableTableManager(_db, _db.masters);
}
