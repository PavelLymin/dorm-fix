import 'dart:async';

import 'l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import 'src/app/logic/composition_root.dart';
import 'src/app/widget/dependencies_scope.dart';
import 'src/features/authentication/authentication.dart';
import 'src/features/profile/profile.dart';
import 'src/features/repair_request/request.dart';
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
                builder: (context, settings) => MainApp(settings: settings),
              ),
            ),
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
  const MainApp({super.key, required this.settings});

  final SettingsEntity settings;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthBloc _authenticationBloc;
  late final ProfileBloc _profileBloc;
  late final RepairRequestBloc _requestBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = DependeciesScope.of(context).authenticationBloc;
    _profileBloc = DependeciesScope.of(context).profileBloc;
    _requestBloc = DependeciesScope.of(context).repairRequestBloc;
  }

  ThemeData get _themeData {
    switch (widget.settings.themeMode) {
      case .light:
        return lightTheme;
      case .dark:
        return darkTheme;
      case .system:
        final brightness = MediaQuery.platformBrightnessOf(context);
        return brightness == Brightness.dark ? darkTheme : lightTheme;
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = DependeciesScope.of(context).router;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _authenticationBloc),
        BlocProvider(create: (context) => _profileBloc),
        BlocProvider(create: (context) => _requestBloc),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: 'Dorm Fix',
        debugShowCheckedModeBanner: false,
        theme: _themeData,
        routerConfig: router.config(),
      ),
    );
  }
}
