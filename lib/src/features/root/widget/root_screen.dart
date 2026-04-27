import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/features/repair_request/request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../app/widget/dependencies_scope.dart';
import 'bottom_navigation.dart';

class AppPage {
  const AppPage({required this.name, required this.title, required this.icon});

  final String name;
  final String title;
  final IconData icon;
}

// class MasterDataScope extends InheritedWidget {
//   const MasterDataScope({
//     super.key,
//     required this.specializationId,
//     required this.dormitoryId,
//     required super.child,
//   });

//   final int specializationId;
//   final int dormitoryId;

//   static MasterDataScope of(BuildContext context) {
//     final scope = context.dependOnInheritedWidgetOfExactType<MasterDataScope>();
//     assert(scope != null, 'MasterDataScope not found');
//     return scope!;
//   }

//   @override
//   bool updateShouldNotify(MasterDataScope oldWidget) {
//     return specializationId != oldWidget.specializationId ||
//         dormitoryId != oldWidget.dormitoryId;
//   }
// }

class MasterRootScreen extends StatefulWidget {
  const MasterRootScreen({
    super.key,
    required this.pages,
    required this.specializationId,
    required this.dormitoryId,
  });

  final List<AppPage> pages;
  final int specializationId;
  final int dormitoryId;

  @override
  State<MasterRootScreen> createState() => _MasterRootScreenState();
}

class _MasterRootScreenState extends State<MasterRootScreen> {
  late final RepairRequestBloc _repairRequestBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _repairRequestBloc = RepairRequestBloc(
      requestRepository: dependency.requestRepository,
      problemRepository: dependency.problemRepository,
      logger: dependency.logger,
    );
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => _repairRequestBloc,
    child: RootScreen(pages: widget.pages),
  );
}

class StudentRootScreen extends StatefulWidget {
  const StudentRootScreen({super.key, required this.pages});

  final List<AppPage> pages;

  @override
  State<StudentRootScreen> createState() => _StudentRootScreenState();
}

class _StudentRootScreenState extends State<StudentRootScreen> {
  late final RepairRequestBloc _repairRequestBloc;

  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _repairRequestBloc = RepairRequestBloc(
      requestRepository: dependency.requestRepository,
      problemRepository: dependency.problemRepository,
      logger: dependency.logger,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RepairRequestBloc>(
      create: (context) => _repairRequestBloc,
      child: RootScreen(pages: widget.pages),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({super.key, required this.pages});

  final List<AppPage> pages;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      lazyLoad: true,
      homeIndex: 0,
      routes: List.generate(
        pages.length,
        (index) => NamedRoute(pages[index].name),
      ),
      builder: (context, child) => Scaffold(
        bottomNavigationBar: BottomNavigation(pages: pages),
        body: child,
      ),
    );
  }
}
