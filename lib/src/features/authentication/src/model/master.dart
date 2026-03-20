part of 'user.dart';

class MasterUser extends ProfileUser {
  const MasterUser({
    required this.id,
    required this.user,
    required this.specialization,
    required this.dormitory,
  });

  final int id;
  final FirebaseUser user;
  final SpecializationEntity specialization;
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
    SpecializationEntity? specialization,
    DormitoryEntity? dormitory,
  }) => MasterUser(
    id: id ?? this.id,
    user: user ?? this.user,
    specialization: specialization ?? this.specialization,
    dormitory: dormitory ?? this.dormitory,
  );

  @override
  String toString() =>
      'MasterEntity('
      'id: $id, '
      'user: $user, '
      'specialization: $specialization, '
      'dormitory: $dormitory)';

  @override
  bool operator ==(Object other) => other is MasterUser && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

final class FakeMaster extends MasterUser {
  const FakeMaster({
    super.id = -1,
    super.user = const .fake(),
    super.specialization = const .fake(),
    super.dormitory = const .fake(),
  });

  @override
  bool get isFake => true;
}
