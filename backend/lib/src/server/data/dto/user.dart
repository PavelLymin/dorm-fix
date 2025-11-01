import 'package:drift/drift.dart';
import '../../../core/database/database.dart';
import '../../model/user.dart';

class UserDto {
  const UserDto({
    required this.uid,
    required this.name,
    required this.photoURL,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  final String uid;
  final String name;
  final String photoURL;
  final String email;
  final String phoneNumber;
  final String role;

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
    role: role ?? this.role,
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'photo_url': photoURL,
    'email': email,
    'phone_number': phoneNumber,
    'role': role,
  };

  static UserDto fromJson(Map<String, dynamic> json) => UserDto(
    uid: json['uid'],
    name: json['name'],
    photoURL: json['photo_url'],
    email: json['email'],
    phoneNumber: json['phone_number'],
    role: json['role'],
  );

  UsersCompanion toCompanion() => UsersCompanion(
    uid: Value(uid),
    name: Value(name),
    photoURL: Value(photoURL),
    email: Value(email),
    phoneNumber: Value(phoneNumber),
    role: Value(role),
  );

  static UserDto fromData(User companion) => UserDto(
    uid: companion.uid,
    name: companion.name,
    photoURL: companion.photoURL,
    email: companion.email,
    phoneNumber: companion.phoneNumber,
    role: companion.role,
  );

  static UserDto fromEntity(UserEntity entity) => UserDto(
    uid: entity.uid,
    name: entity.name,
    photoURL: entity.photoURL,
    email: entity.email,
    phoneNumber: entity.phoneNumber,
    role: entity.role,
  );

  UserEntity toEntity() => UserEntity(
    uid: uid,
    name: name,
    photoURL: photoURL,
    email: email,
    phoneNumber: phoneNumber,
    role: role,
  );

  @override
  String toString() =>
      'UserDto('
      'uid: $uid, '
      'name: $name, '
      'photoURL: $photoURL, '
      'email: $email, '
      'phoneNumber: $phoneNumber, '
      'role: $role)';

  @override
  bool operator ==(Object other) => other is UserDto && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}
