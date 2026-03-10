part of 'user.dart';

sealed class StudentUser {
  const StudentUser();

  const factory StudentUser.partial({
    required FirebaseUser user,
    required int dormitoryId,
    required int roomId,
  }) = PartialStudent;

  const factory StudentUser.full({
    required int id,
    required FirebaseUser user,
    required DormitoryEntity dormitory,
    required RoomEntity room,
  }) = FullStudent;

  String get uid;

  StudentUser copyWith();
}

class FullStudent extends ProfileUser implements StudentUser {
  const FullStudent({
    required this.user,
    required this.id,
    required this.dormitory,
    required this.room,
  });

  final int id;
  final FirebaseUser user;
  final DormitoryEntity dormitory;
  final RoomEntity room;

  const factory FullStudent.fake() = FakeStudent;

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

  @override
  FullStudent copyWith({
    int? id,
    FirebaseUser? user,
    DormitoryEntity? dormitory,
    RoomEntity? room,
  }) => FullStudent(
    id: id ?? this.id,
    user: user ?? this.user,
    dormitory: dormitory ?? this.dormitory,
    room: room ?? this.room,
  );

  @override
  String toString() =>
      'FullStudent('
      'id: $id, '
      'user: $user, '
      'dormitory: $dormitory, '
      'room: $room)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is FullStudent && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class PartialStudent implements StudentUser {
  const PartialStudent({
    required this.user,
    required this.dormitoryId,
    required this.roomId,
  });

  final FirebaseUser user;
  final int dormitoryId;
  final int roomId;

  @override
  String get uid => user.uid;

  @override
  PartialStudent copyWith({
    FirebaseUser? user,
    int? dormitoryId,
    int? roomId,
  }) => PartialStudent(
    user: user ?? this.user,
    dormitoryId: dormitoryId ?? this.dormitoryId,
    roomId: roomId ?? this.roomId,
  );

  @override
  String toString() =>
      'PartialStudent('
      'user: $user, '
      'dormitoryId: $dormitoryId, '
      'roomId: $roomId)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartialStudent &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          dormitoryId == other.dormitoryId &&
          roomId == other.roomId;

  @override
  int get hashCode => Object.hash(user, dormitoryId, roomId);
}

final class FakeStudent extends FullStudent {
  const FakeStudent({
    super.user = const .fake(),
    super.id = 0,
    super.dormitory = const .fake(),
    super.room = const .fake(),
  });

  @override
  bool get isFake => true;
}
