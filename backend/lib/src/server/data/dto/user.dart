import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/user.dart';

class UserDto {
  const UserDto({
    required this.uid,
    required this.displayName,
    required this.photoURL,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  final String uid;
  final String displayName;
  final String photoURL;
  final String email;
  final String phoneNumber;
  final Role role;

  UserDto copyWith({
    String? uid,
    String? displayName,
    String? photoURL,
    String? email,
    String? phoneNumber,
    Role? role,
  }) => UserDto(
    uid: uid ?? this.uid,
    displayName: displayName ?? this.displayName,
    photoURL: photoURL ?? this.photoURL,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    role: role ?? this.role,
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'display_name': displayName,
    'photo_url': photoURL,
    'email': email,
    'phone_number': phoneNumber,
    'role': role.name,
  };

  static UserDto fromJson(Map<String, dynamic> json) => UserDto(
    uid: json['uid'],
    displayName: json['display_name'],
    photoURL: json['photo_url'],
    email: json['email'],
    phoneNumber: json['phone_number'],
    role: Role.fromString(json['role']),
  );

  UsersCompanion toCompanion() => UsersCompanion(
    uid: Value(uid),
    displayName: Value(displayName),
    photoURL: Value(photoURL),
    email: Value(email),
    phoneNumber: Value(phoneNumber),
    role: Value(role.name),
  );

  static UserDto fromData(User companion) => UserDto(
    uid: companion.uid,
    displayName: companion.displayName,
    photoURL: companion.photoURL,
    email: companion.email,
    phoneNumber: companion.phoneNumber,
    role: Role.fromString(companion.role),
  );

  static UserDto fromEntity(UserEntity entity) => UserDto(
    uid: entity.uid,
    displayName: entity.displayName,
    photoURL: entity.photoURL,
    email: entity.email,
    phoneNumber: entity.phoneNumber,
    role: entity.role,
  );

  UserEntity toEntity() => UserEntity(
    uid: uid,
    displayName: displayName,
    photoURL: photoURL,
    email: email,
    phoneNumber: phoneNumber,
    role: role,
  );

  @override
  String toString() =>
      'UserDto('
      'uid: $uid, '
      'displayName: $displayName, '
      'photoURL: $photoURL, '
      'email: $email, '
      'phoneNumber: $phoneNumber)';

  @override
  bool operator ==(Object other) => other is UserDto && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
