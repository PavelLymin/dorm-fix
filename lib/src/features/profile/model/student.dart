import '../../authentication/model/user.dart';
import '../../room/model/room.dart';
import '../../yandex_mapkit/model/dormitory.dart';

abstract class StudentEntity extends UserEntity {
  const StudentEntity();

  factory StudentEntity.empty() => StudentEmpty();

  factory StudentEntity.created({
    required int dormitoryId,
    required int roomId,
    required AuthenticatedUser user,
  }) => CreatedStudentEntity(
    dormitoryId: dormitoryId,
    roomId: roomId,
    user: user,
  );

  factory StudentEntity.full({
    required int id,
    required AuthenticatedUser user,
    required DormitoryEntity dormitory,
    required RoomEntity room,
  }) => FullStudentEntity(id: id, user: user, dormitory: dormitory, room: room);

  String get uid;

  StudentEntity copyWith();

  @override
  bool operator ==(Object other) => other is StudentEntity && uid == other.uid;

  @override
  int get hashCode => uid.hashCode;
}

class CreatedStudentEntity extends StudentEntity {
  const CreatedStudentEntity({
    required this.user,
    required this.dormitoryId,
    required this.roomId,
  });

  final AuthenticatedUser user;
  final int dormitoryId;
  final int roomId;

  @override
  String get uid => user.uid;

  @override
  CreatedStudentEntity copyWith({
    int? dormitoryId,
    int? roomId,
    AuthenticatedUser? user,
  }) => CreatedStudentEntity(
    dormitoryId: dormitoryId ?? this.dormitoryId,
    roomId: roomId ?? this.roomId,
    user: user ?? this.user,
  );

  @override
  String toString() =>
      'UserEntity('
      'dormitoryId: $dormitoryId, '
      'roomId: $roomId, '
      'user: $user)';

  @override
  bool get isAuthenticated => !isNotAuthenticated;

  @override
  bool get isNotAuthenticated => uid.isEmpty;

  @override
  AuthenticatedUser? get authenticatedOrNull =>
      isNotAuthenticated ? null : user;

  @override
  T map<T>({
    required T Function(NotAuthenticatedUser user) notAuthenticatedUser,
    required T Function(AuthenticatedUser user) authenticatedUser,
  }) => authenticatedUser(user);
}

class FullStudentEntity extends StudentEntity {
  const FullStudentEntity({
    required this.id,
    required this.user,
    required this.dormitory,
    required this.room,
  });

  final int id;
  final AuthenticatedUser user;
  final DormitoryEntity dormitory;
  final RoomEntity room;

  @override
  String get uid => user.uid;

  @override
  FullStudentEntity copyWith({
    int? id,
    DormitoryEntity? dormitory,
    RoomEntity? room,
    AuthenticatedUser? user,
  }) => FullStudentEntity(
    id: id ?? this.id,
    user: user ?? this.user,
    dormitory: dormitory ?? this.dormitory,
    room: room ?? this.room,
  );

  @override
  String toString() =>
      'UserEntity('
      'id: $id, '
      'user: $user, '
      'dormitory: $dormitory, '
      'room: $room)';

  @override
  bool get isAuthenticated => !isNotAuthenticated;

  @override
  bool get isNotAuthenticated => uid.isEmpty;

  @override
  AuthenticatedUser? get authenticatedOrNull =>
      isNotAuthenticated ? null : user;

  @override
  T map<T>({
    required T Function(NotAuthenticatedUser user) notAuthenticatedUser,
    required T Function(AuthenticatedUser user) authenticatedUser,
  }) => authenticatedUser(user);
}

class StudentEmpty extends StudentEntity {
  const StudentEmpty();

  @override
  String get uid => '';

  @override
  StudentEmpty copyWith() => const StudentEmpty();

  @override
  bool get isAuthenticated => false;

  @override
  bool get isNotAuthenticated => true;

  @override
  AuthenticatedUser? get authenticatedOrNull => null;

  @override
  T map<T>({
    required T Function(NotAuthenticatedUser user) notAuthenticatedUser,
    required T Function(AuthenticatedUser user) authenticatedUser,
  }) => notAuthenticatedUser(const NotAuthenticatedUser());
}
