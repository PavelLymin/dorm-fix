import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'src/app/logic/composition_root.dart';
import 'src/app/widget/dependencies_scope.dart';
import 'src/features/authentication/state_management/authentication/authentication_bloc.dart';

void main() async {
  final logger = CreateAppLogger().create();
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final dependency = await CompositionRoot(logger: logger).compose();

      runApp(
        DependeciesScope(
          dependencyContainer: dependency,
          child: const WindowSizeScope(
            updateMode: WindowSizeUpdateMode.categoriesOnly,
            child: MainApp(),
          ),
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

  @override
  void initState() {
    super.initState();
    _authenticationBloc = DependeciesScope.of(context).authenticationBloc;
  }

  @override
  Widget build(BuildContext context) {
    final router = DependeciesScope.of(context).router;
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => _authenticationBloc)],
      child: MaterialApp.router(
        title: 'Dorm Fix',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        routerConfig: router.config(),
      ),
    );
  }
}
