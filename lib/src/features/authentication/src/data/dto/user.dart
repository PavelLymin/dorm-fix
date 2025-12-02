import 'package:firebase_auth/firebase_auth.dart';
import '../../../authentication.dart';

class UserDto {
  const UserDto({
    required this.uid,
    required this.displayName,
    required this.photoURL,
    required this.email,
    required this.phoneNumber,
  });

  final String uid;
  final String? displayName;
  final String? photoURL;
  final String? email;
  final String? phoneNumber;

  factory UserDto.fromFirebase(User user) => UserDto(
    uid: user.uid,
    displayName: user.displayName,
    photoURL: user.photoURL,
    email: user.email,
    phoneNumber: user.phoneNumber,
  );

  AuthenticatedUser toEntity() => AuthenticatedUser(
    uid: uid,
    displayName: displayName,
    photoURL: photoURL,
    email: email,
    phoneNumber: phoneNumber,
  );

  factory UserDto.fromEntity(AuthenticatedUser user) => UserDto(
    uid: user.uid,
    displayName: user.displayName,
    photoURL: user.photoURL,
    email: user.email,
    phoneNumber: user.phoneNumber,
  );

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'display_name': displayName,
      'photo_url': photoURL,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  factory UserDto.fromJson(Map<String, Object?> json) {
    if (json case <String, Object?>{
      'uid': final String uid,
      'display_name': final String? displayName,
      'photo_url': final String? photoURL,
      'email': final String? email,
      'phone_number': final String? phoneNumber,
    }) {
      return UserDto(
        uid: uid,
        displayName: displayName,
        photoURL: photoURL,
        email: email,
        phoneNumber: phoneNumber,
      );
    }
    throw ArgumentError('Invalid JSON data for User: $json');
  }
}
