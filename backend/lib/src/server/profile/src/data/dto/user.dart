import 'package:drift/drift.dart';
import '../../../../../core/database/database.dart';
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
    role: .fromString(companion.role),
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'display_name': displayName,
    'photo_url': photoURL,
    'email': email,
    'phone_number': phoneNumber,
    'role': role.name,
  };

  factory UserDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'uid': final String uid,
      'display_name': final String? displayName,
      'photo_url': final String? photoURL,
      'email': final String? email,
      'phone_number': final String? phoneNumber,
      'role': final String role,
    }) {
      return UserDto(
        uid: uid,
        displayName: displayName,
        photoURL: photoURL,
        email: email,
        phoneNumber: phoneNumber,
        role: .fromString(role),
      );
    } else {
      throw ArgumentError('Invalid JSON format for UserDto: $json');
    }
  }
}
