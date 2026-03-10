part of 'user.dart';

class MasterUser extends ProfileUser {
  const MasterUser({
    required this.user,
    required this.id,
    required this.dormitory,
  });

  final int id;
  final FirebaseUser user;
  final DormitoryEntity dormitory;

  const factory MasterUser.fake() = FakeMaster;

  @override
  String get uid => user.uid;
  @override
  String? get displayName => user.displayName;
  @override
  String? get email => user.email;
  @override
  String? get phoneNumber => user.phoneNumber;
  @override
  String? get photoURL => user.photoURL;
  @override
  Role get role => user.role;

  @override
  AuthenticatedUser get authenticatedOrNull => this;
  @override
  bool get isAuthenticated => true;
  @override
  bool get isNotAuthenticated => false;

  @override
  bool get isFake => false;

  MasterUser copyWith({
    int? id,
    FirebaseUser? user,
    DormitoryEntity? dormitory,
  }) => MasterUser(
    id: id ?? this.id,
    user: user ?? this.user,
    dormitory: dormitory ?? this.dormitory,
  );

  @override
  String toString() =>
      'MasterEntity('
      'id: $id, '
      'user: $user, '
      'dormitory: $dormitory)';

  @override
  bool operator ==(Object other) => other is MasterUser && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

final class FakeMaster extends MasterUser {
  const FakeMaster({
    super.user = const .fake(),
    super.id = 0,
    super.dormitory = const .fake(),
  });

  @override
  bool get isFake => true;
}
