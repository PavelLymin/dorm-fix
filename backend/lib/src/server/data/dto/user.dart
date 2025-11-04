import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/user.dart';

enum Role {
  student(name: 'student'),
  master(name: 'master');

  const Role({required this.name});

  final String name;

  static Role fromString(String name) => values.firstWhere(
    (role) => role.name == name,
    orElse: () => throw FormatException('Unknown role: $name'),
  );

  T map<T>({required T Function() student, required T Function() master}) =>
      switch (this) {
        Role.student => student(),
        Role.master => master(),
      };
}

class UserDto {
  const UserDto({
    required this.uid,
    required this.name,
    required this.photoURL,
    required this.email,
    required this.phoneNumber,
  });

  final String uid;
  final String name;
  final String photoURL;
  final String email;
  final String phoneNumber;

  UserDto copyWith({
    String? uid,
    String? name,
    String? photoURL,
    String? email,
    String? phoneNumber,
    String? role,
  }) => UserDto(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    photoURL: photoURL ?? this.photoURL,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'photo_url': photoURL,
    'email': email,
    'phone_number': phoneNumber,
  };

  static UserDto fromJson(Map<String, dynamic> json) => UserDto(
    uid: json['uid'],
    name: json['name'],
    photoURL: json['photo_url'],
    email: json['email'],
    phoneNumber: json['phone_number'],
  );

  UsersCompanion toCompanion() => UsersCompanion(
    uid: Value(uid),
    name: Value(name),
    photoURL: Value(photoURL),
    email: Value(email),
    phoneNumber: Value(phoneNumber),
  );

  static UserDto fromData(User companion) => UserDto(
    uid: companion.uid,
    name: companion.name,
    photoURL: companion.photoURL,
    email: companion.email,
    phoneNumber: companion.phoneNumber,
  );

  static UserDto fromEntity(UserEntity entity) => UserDto(
    uid: entity.uid,
    name: entity.name,
    photoURL: entity.photoURL,
    email: entity.email,
    phoneNumber: entity.phoneNumber,
  );

  UserEntity toEntity() => UserEntity(
    uid: uid,
    name: name,
    photoURL: photoURL,
    email: email,
    phoneNumber: phoneNumber,
  );

  @override
  String toString() =>
      'UserDto('
      'uid: $uid, '
      'name: $name, '
      'photoURL: $photoURL, '
      'email: $email, '
      'phoneNumber: $phoneNumber)';

  @override
  bool operator ==(Object other) => other is UserDto && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
