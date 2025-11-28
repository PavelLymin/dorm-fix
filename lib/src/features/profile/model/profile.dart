import '../../authentication/model/user.dart';
import '../../room/model/room.dart';
import '../../yandex_mapkit/model/dormitory.dart';
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
      Role.student => FullStudentDto.fromJson(json).toEntity(),
      Role.master => MasterDto.fromJson(json).toEntity(),
    };

    return entity;
  }

  T map<T>({
    required T Function(FullStudentEntity student) student,
    required T Function(MasterEntity master) master,
  }) {
    switch (this) {
      case FullStudentEntity():
        return student(this as FullStudentEntity);
      case MasterEntity():
        return master(this as MasterEntity);
      default:
        throw UnimplementedError('Unknown ProfileEntity type: $runtimeType');
    }
  }
}

class ProfileEntityEmpty extends ProfileEntity {
  const ProfileEntityEmpty();
}
