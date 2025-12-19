import 'package:firebase_auth/firebase_auth.dart';
import '../../../authentication.dart';

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
  final String? displayName;
  final String? photoURL;
  final String? email;
  final String? phoneNumber;
  final Role? role;

  factory UserDto.fromFirebase(User user) => UserDto(
    uid: user.uid,
    displayName: user.displayName,
    photoURL: user.photoURL,
    email: user.email,
    phoneNumber: user.phoneNumber,
    role: Role.student,
  );

  AuthenticatedUser toEntity() => AuthenticatedUser(
    uid: uid,
    displayName: displayName,
    photoURL: photoURL,
    email: email,
    phoneNumber: phoneNumber,
    role: role,
  );

  factory UserDto.fromEntity(AuthenticatedUser user) => UserDto(
    uid: user.uid,
    displayName: user.displayName,
    photoURL: user.photoURL,
    email: user.email,
    phoneNumber: user.phoneNumber,
    role: user.role,
  );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'display_name': displayName,
      'photo_url': photoURL,
      'email': email,
      'phone_number': phoneNumber,
      'role': role?.name,
    };
  }

  factory UserDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'uid': final String uid,
      'display_name': final String? displayName,
      'photo_url': final String? photoURL,
      'email': final String? email,
      'phone_number': final String? phoneNumber,
      'role': final String? role,
    }) {
      return UserDto(
        uid: uid,
        displayName: displayName,
        photoURL: photoURL,
        email: email,
        phoneNumber: phoneNumber,
        role: role == null ? Role.student : Role.fromString(role),
      );
    }
    throw ArgumentError('Invalid JSON data for User: $json');
  }
}
