import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';
import 'bottom_navigation.dart';

class AppPage {
  const AppPage({required this.name, required this.title, required this.icon});

  final String name;
  final String title;
  final IconData icon;
}

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
  @override
  Widget build(BuildContext context) => RootScreen(pages: widget.pages);
}

class StudentRootScreen extends StatefulWidget {
  const StudentRootScreen({super.key, required this.pages});

  final List<AppPage> pages;

  @override
  State<StudentRootScreen> createState() => _StudentRootScreenState();
}

class _StudentRootScreenState extends State<StudentRootScreen> {
  @override
  Widget build(BuildContext context) {
    return RootScreen(pages: widget.pages);
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
