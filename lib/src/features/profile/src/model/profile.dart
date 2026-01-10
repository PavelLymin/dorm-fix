import '../../../authentication/src/model/user.dart';
import '../../../room/src/model/room.dart';
import '../../../dormitory/src/model/dormitory.dart';
import '../data/dto/master.dart';
import '../data/dto/student.dart';

part 'student.dart';
part 'master.dart';

sealed class ProfileEntity {
  const ProfileEntity();

  factory ProfileEntity.empty() => const ProfileEntityEmpty();

  factory ProfileEntity.fromRole({
    required Role role,
    required Map<String, Object?> json,
  }) {
    final entity = switch (role) {
      .student => FullStudentDto.fromJson(json).toEntity(),
      .master => MasterDto.fromJson(json).toEntity(),
    };

    return entity;
  }

  T map<T>({
    required T Function(FullStudentEntity student) student,
    required T Function(MasterEntity master) master,
  }) => switch (this) {
    FullStudentEntity() => student(this as FullStudentEntity),
    MasterEntity() => master(this as MasterEntity),
    _ => throw UnimplementedError('Unknown ProfileEntity type: $runtimeType'),
  };
}

class ProfileEntityEmpty extends ProfileEntity {
  const ProfileEntityEmpty();
}
