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

  const FirebaseUser.fake()
    : this(
        uid: 'uid',
        displayName: 'displayName',
        photoURL: null,
        email: 'email@example.com',
        phoneNumber: '+1234567890',
        role: .student,
      );

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
