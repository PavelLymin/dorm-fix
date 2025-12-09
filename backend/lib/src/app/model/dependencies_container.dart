import 'package:backend/src/server/router/request.dart';
import 'package:firebase_admin/firebase_admin.dart';
import '../../core/database/database.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../../server/router/dormitory.dart';
import '../../server/router/profile.dart';
import '../../server/router/room.dart';
import '../../server/router/specialization.dart';
import '../../server/router/student.dart';
import '../../server/router/user.dart';
import 'application_config.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.firebaseAdmin,
    required this.config,
    required this.restApi,
    required this.database,
    required this.userRouter,
    required this.requestRouter,
    required this.profileRouter,
    required this.studentRouter,
    required this.dormitoryRouter,
    required this.roomRouter,
    required this.specializationRouter,
  });

  final App firebaseAdmin;

  final Config config;

  final RestApi restApi;

  final Database database;

  final UserRouter userRouter;

  final RequestRouter requestRouter;

  final ProfileRouter profileRouter;

  final StudentRouter studentRouter;

  final DormitoryRouter dormitoryRouter;

  final RoomRouter roomRouter;

  final SpecializationRouter specializationRouter;
}
