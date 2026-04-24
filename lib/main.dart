import 'dart:async';

import 'package:dorm_fix/src/features/dormitory/dormitory.dart';
import 'package:dorm_fix/src/features/specialization/specialization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ui_kit/ui.dart';
import 'l10n/gen/app_localizations.dart';
import 'src/app/logic/composition_root.dart';
import 'src/app/widget/dependencies_scope.dart';
import 'src/features/authentication/authentication.dart';
import 'src/features/settings/settings.dart';

void main() async {
  final logger = CreateAppLogger().create();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final dependency = await CompositionRoot(logger: logger).compose();
      runApp(
        DependeciesScope(
          dependencyContainer: dependency,
          child: SettingsScope(
            settingsContainer: dependency.settingsContainer,
            child: WindowSizeScope(
              updateMode: .categoriesOnly,
              child: SettingsBuilder(
                builder: (_, settings) => MainApp(settings: settings),
              ),
            ),
          ),
        ),
      );
    },
    (error, stackTrace) {
      logger.e(error, stackTrace: stackTrace);
      Error.throwWithStackTrace(error, stackTrace);
    },
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.settings});

  final SettingsEntity settings;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthBloc _authenticationBloc;
  late final SpecializationBloc _specializationBloc;
  late final DormitoryBloc _dormitoryBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = DependeciesScope.of(context).authenticationBloc;
    _specializationBloc = DependeciesScope.of(context).specializationBloc;
    _dormitoryBloc = DependeciesScope.of(context).dormitoryBloc;
  }

  @override
  Widget build(BuildContext context) {
    final router = DependeciesScope.of(context).router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _authenticationBloc),
        BlocProvider(create: (context) => _specializationBloc),
        BlocProvider(create: (context) => _dormitoryBloc),
      ],
      child: MaterialApp.router(
        title: 'Dorm Fix',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en'), Locale('ru')],
        locale: SettingsScope.ofLocale(context, widget.settings),
        theme: SettingsScope.ofThemeData(context, widget.settings),
        routerConfig: router.config(),
      ),
    );
  }
}
