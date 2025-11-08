import 'dart:async';

import 'package:dorm_fix/src/features/authentication/widget/signin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'src/app/bloc/app_bloc_observer.dart';
import 'src/app/logic/composition_root.dart';
import 'src/app/widget/dependencies_scope.dart';
import 'src/features/authentication/state_management/authentication/authentication_bloc.dart';
import 'src/features/profile/student/state_management/bloc/student_bloc.dart';

void main() async {
  final logger = CreateAppLogger().create();
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final dependency = await CompositionRoot(logger: logger).compose();

      Bloc.observer = AppBlocObserver(logger: logger);

      runApp(
        DependeciesScope(
          dependencyContainer: dependency,
          child: WindowSizeScope(child: const MainApp()),
        ),
      );
    },
    (error, stackTrace) {
      logger.e(error, stackTrace: stackTrace);
    },
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late AuthBloc _authenticationBloc;
  late StudentBloc _studentBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = DependeciesScope.of(context).authenticationBloc;
    _studentBloc = DependeciesScope.of(context).studentBloc;
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => _authenticationBloc),
      BlocProvider(create: (context) => _studentBloc),
    ],
    child: MaterialApp(
      title: 'Dorm Fix',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const SignIn(),
    ),
  );
}
