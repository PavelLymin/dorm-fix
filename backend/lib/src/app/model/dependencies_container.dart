import 'package:backend/src/app/model/application_config.dart';
import 'package:firebase_admin/firebase_admin.dart';
import '../../core/database/database.dart';
import '../../server/router/building.dart';
import '../../server/router/student.dart';

class DependencyContainer {
  const DependencyContainer({
    required this.firebaseAdmin,
    required this.config,
    required this.database,
    required this.studentRouter,
    required this.buildingRouter,
  });
  final App firebaseAdmin;

  final Config config;

  final Database database;

  final StudentRouter studentRouter;

  final BuildingRouter buildingRouter;
}
