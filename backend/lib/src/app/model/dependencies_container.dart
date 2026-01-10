import 'package:firebase_admin/firebase_admin.dart';
import '../../core/database/database.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../../core/ws/ws.dart';
import '../../server/repair_request/repair_request.dart';
import '../../server/dormitory/src/router/dormitory.dart';
import '../../server/profile/src/router/profile.dart';
import '../../server/room/src/router/room.dart';
import '../../server/specialization/src/router/specialization.dart';
import '../../server/profile/src/router/user.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.firebaseAdmin,
    required this.restApi,
    required this.wsRouter,
    required this.database,
    required this.userRouter,
    required this.profileRouter,
    required this.roomRouter,
    required this.dormitoryRouter,
    required this.repairRequestRouter,
    required this.specializationRouter,
  });

  final App firebaseAdmin;

  final RestApi restApi;

  final WsRouter wsRouter;

  final Database database;

  final UserRouter userRouter;

  final ProfileRouter profileRouter;

  final RoomRouter roomRouter;

  final DormitoryRouter dormitoryRouter;

  final RepairRequestRouter repairRequestRouter;

  final SpecializationRouter specializationRouter;
}
