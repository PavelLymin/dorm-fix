part of 'user.dart';

class FirebaseUser extends AuthenticatedUser {
  const FirebaseUser({
    required this._uid,
    required this._displayName,
    required this._photoURL,
    required this._email,
    required this._phoneNumber,
    this._role = .student,
  });

  final String _uid;
  final String? _displayName;
  final String? _photoURL;
  final String? _email;
  final String? _phoneNumber;
  final Role _role;

  FirebaseUser copyWith({
    String? uid,
    String? displayName,
    String? photoURL,
    String? email,
    String? phoneNumber,
    Role? role,
  }) => FirebaseUser(
    uid: uid ?? _uid,
    displayName: displayName ?? _displayName,
    photoURL: photoURL ?? _photoURL,
    email: email ?? _email,
    phoneNumber: phoneNumber ?? _phoneNumber,
    role: role ?? _role,
  );

  FirebaseUser copyWithPatch({
    String? uid,
    required Option<String> displayName,
    required Option<String> photoURL,
    required Option<String> email,
    required Option<String> phoneNumber,
    Role? role,
  }) => FirebaseUser(
    uid: uid ?? _uid,
    displayName: displayName.isAbsent ? null : displayName.value,
    photoURL: photoURL.isAbsent ? null : photoURL.value,
    email: email.isAbsent ? null : email.value,
    phoneNumber: phoneNumber.isAbsent ? null : phoneNumber.value,
    role: role ?? _role,
  );

  const FirebaseUser.fake()
    : this(
        uid: 'uid',
        displayName: 'displayName',
        photoURL: null,
        email: 'email@example.com',
        phoneNumber: '+1234567890',
        role: .student,
      );

  bool get isFake => this == FirebaseUser.fake();

  @override
  String get uid => _uid;
  @override
  String? get displayName => _displayName;
  @override
  String? get email => _email;
  @override
  String? get phoneNumber => _phoneNumber;
  @override
  String? get photoURL => _photoURL;
  @override
  Role get role => _role;

  @override
  AuthenticatedUser get authenticatedOrNull => this;

  @override
  bool get isAuthenticated => true;

  @override
  bool get isNotAuthenticated => false;
}
