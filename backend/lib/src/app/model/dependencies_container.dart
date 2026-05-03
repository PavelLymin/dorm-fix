import 'package:firebase_admin/firebase_admin.dart';
import '../../core/database/database.dart';
import '../../core/rest_api/src/rest_api.dart';
import '../../core/ws/ws.dart';
import '../../server/chat/chat.dart';
import '../../server/chat/src/router/message.dart';
import '../../server/instruction/src/router/instruction.dart';
import '../../server/master/master.dart';
import '../../server/material/material.dart';
import '../../server/repair_request/repair_request.dart';
import '../../server/dormitory/src/router/dormitory.dart';
import '../../server/profile/src/router/profile.dart';
import '../../server/room/src/router/room.dart';
import '../../server/profile/src/router/user.dart';
import '../../server/specialization/specialization.dart';
import '../../server/student/student.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.firebaseAdmin,
    required this.restApi,
    required this.wsRouter,
    required this.database,
    required this.masterRouter,
    required this.userRouter,
    required this.profileRouter,
    required this.roomRouter,
    required this.dormitoryRouter,
    required this.repairRequestRouter,
    required this.specializationRouter,
    required this.chatRouter,
    required this.messageRouter,
    required this.studentRouter,
    required this.materialRouter,
    required this.instructionRouter,
  });

  final App firebaseAdmin;

  final RestApi restApi;

  final WsRouter wsRouter;

  final Database database;

  final MasterRouter masterRouter;

  final UserRouter userRouter;

  final ProfileRouter profileRouter;

  final RoomRouter roomRouter;

  final DormitoryRouter dormitoryRouter;

  final RepairRequests repairRequestRouter;

  final SpecializationRouter specializationRouter;

  final CharRouter chatRouter;

  final MessageRouter messageRouter;

  final StudentRouter studentRouter;

  final MaterialService materialRouter;

  final InstructionService instructionRouter;
}
