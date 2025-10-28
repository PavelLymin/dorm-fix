import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'src/app/logic/composition_root.dart';
import 'src/app/widget/dependencies_scope.dart';
import 'src/features/authentication/state_management/authentication/authentication_bloc.dart';
import 'src/features/authentication/widget/signin.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    final dependency = await CompositionRoot().compose();

    runApp(
      DependeciesScope(
        dependencyContainer: dependency,
        child: WindowSizeScope(child: const MainApp()),
      ),
    );
  }, (error, stackTrace) {});
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late AuthBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = DependeciesScope.of(context).authenticationBloc;
  }

  @override
  Widget build(BuildContext context) => PinScope(
    child: MultiBlocProvider(
      providers: [BlocProvider(create: (context) => _authenticationBloc)],
      child: MaterialApp(
        title: 'Dorm Fix',
        debugShowCheckedModeBanner: false,
        home: const SignIn(),
      ),
    ),
  );
}
