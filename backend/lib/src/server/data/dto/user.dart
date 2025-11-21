import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/user.dart';

class UserDto {
  const UserDto({
    required this.uid,
    this.displayName,
    this.photoURL,
    this.email,
    this.phoneNumber,
    required this.role,
  });

  final String uid;
  final String? displayName;
  final String? photoURL;
  final String? email;
  final String? phoneNumber;
  final Role role;

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'display_name': displayName,
    'photo_url': photoURL,
    'email': email,
    'phone_number': phoneNumber,
    'role': role.name,
  };

  factory UserDto.fromJson(Map<String, Object?> json) => UserDto(
    uid: json['uid'] as String,
    displayName: json['display_name'] as String?,
    photoURL: json['photo_url'] as String?,
    email: json['email'] as String?,
    phoneNumber: json['phone_number'] as String?,
    role: Role.fromString(json['role'] as String),
  );

  UsersCompanion toCompanion() => UsersCompanion(
    uid: Value(uid),
    displayName: Value(displayName),
    photoURL: Value(photoURL),
    email: Value(email),
    phoneNumber: Value(phoneNumber),
    role: Value(role.name),
  );

  factory UserDto.fromData(User companion) => UserDto(
    uid: companion.uid,
    displayName: companion.displayName,
    photoURL: companion.photoURL,
    email: companion.email,
    phoneNumber: companion.phoneNumber,
    role: Role.fromString(companion.role),
  );

  UserEntity toEntity() => UserEntity(
    uid: uid,
    displayName: displayName,
    photoURL: photoURL,
    email: email,
    phoneNumber: phoneNumber,
    role: role,
  );

  factory UserDto.fromEntity(UserEntity entity) => UserDto(
    uid: entity.uid,
    displayName: entity.displayName,
    photoURL: entity.photoURL,
    email: entity.email,
    phoneNumber: entity.phoneNumber,
    role: entity.role,
  );
}
