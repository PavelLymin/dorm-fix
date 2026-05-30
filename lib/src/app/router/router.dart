import 'package:auto_route/auto_route.dart';
import 'package:dorm_fix/src/app/widget/dependencies_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../features/authentication/authentication.dart';
import '../../features/instructions/instructions.dart';
import '../../features/map/map.dart';
import '../../features/master/master.dart';
import '../../features/material/material.dart';
import '../../features/specialization/specialization.dart';
import '../../features/profile/profile.dart';
import '../../features/repair_request/request.dart';
import '../../features/root/widget/root_screen.dart';
import '../../features/students/student.dart';

class AppRouter extends RootStackRouter {
  AppRouter({required this.authGuard});

  final AuthGuard authGuard;

  @override
  List<AutoRoute> get routes => [
    NamedRouteDef(
      initial: true,
      name: 'SplashScreen',
      guards: [authGuard],
      builder: (_, _) => const SplashScreen(),
    ),
    NamedRouteDef(name: 'SignIn', builder: (_, _) => const AuthScreen()),
    NamedRouteDef(
      name: 'PincodeScreen',
      builder: (_, data) {
        final phoneNumber = data.params.get('phone_number');
        final verificationId = data.params.get('verification_id');
        return PincodeScreen(
          phoneNumber: phoneNumber,
          verificationId: verificationId,
        );
      },
    ),
    NamedRouteDef(name: 'MapScreen', builder: (_, _) => const MapScreen()),
    NamedRouteDef(
      name: 'UpdatePhoneScreen',
      builder: (_, data) => UpdatePhoneScreen(user: data.params.get('user')),
    ),
    NamedRouteDef(
      name: 'ExtraDataScreen',
      builder: (_, data) => ExtraDataScreen(
        dormitoryId: data.params.getInt('dormitory_id'),
        roomId: data.params.getInt('room_id'),
      ),
    ),
    NamedRouteDef(
      name: 'SpecializationScreen',
      builder: (_, data) {
        final specialization = data.params.get('specialization');
        return SpecializationScreen(specialization: specialization);
      },
    ),
    NamedRouteDef(
      name: 'RepairRequestDetails',
      builder: (_, data) => RepairRequestDetails(
        request: data.params.get('request'),
        images: data.params.get('images'),
      ),
    ),
    NamedRouteDef(
      name: 'StudentRootScreen',
      builder: (context, _) {
        final dependency = DependeciesScope.of(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RepairWatcherBloc(
                requestRepository: dependency.requestRepository,
                logger: dependency.logger,
              ),
            ),
            BlocProvider(
              create: (context) => InstructionBloc(
                instructionRepository: dependency.instructionRepository,
                logger: dependency.logger,
              ),
            ),
          ],
          child: const AutoRouter(),
        );
      },
      children: [
        NamedRouteDef(
          name: 'StudentTabsScreen',
          initial: true,
          builder: (_, _) => RootScreen(pages: studentPages),
          children: [
            NamedRouteDef(
              name: 'StudentHomeTab',
              builder: (_, _) => const StudentHomeScreen(),
            ),
            NamedRouteDef(
              name: 'FormRequestTab',
              builder: (_, _) => const FormRequestScreen(),
            ),
            NamedRouteDef(
              name: 'ProfileTab',
              builder: (_, _) => const ProfileScreen(),
            ),
          ],
        ),
        NamedRouteDef(
          name: 'InstructionsScreen',
          builder: (_, _) => const InstructionsScreen(),
        ),
        NamedRouteDef(
          name: 'InstructionDetails',
          builder: (_, data) =>
              InstructionDetails(instruction: data.params.get('instruction')),
        ),
        NamedRouteDef(
          name: 'FormRequestScreen',
          builder: (_, _) => const FormRequestScreen(),
        ),
        NamedRouteDef(
          name: 'HistoryScreen',
          builder: (_, _) => const HistoryScreen(),
        ),
      ],
    ),
    NamedRouteDef(
      name: 'MasterRootScreen',
      builder: (context, data) {
        final dependency = DependeciesScope.of(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => RepairWatcherBloc(
                requestRepository: dependency.requestRepository,
                logger: dependency.logger,
              ),
            ),
            BlocProvider(
              create: (context) => MaterialTypeBloc(
                materialTypeRepository: dependency.materialTypeRepository,
                logger: dependency.logger,
              )..add(.get()),
            ),
            BlocProvider(
              create: (context) => MaterialBloc(
                materialRepository: dependency.materialRepository,
                logger: dependency.logger,
              )..add(.get()),
            ),
          ],
          child: AutoRouter(),
        );
      },
      children: [
        NamedRouteDef(
          name: 'MasterRootTabs',
          initial: true,
          builder: (_, data) => MasterRootScreen(
            pages: masterPages,
            specializationId: data.parent!.params.getInt('spec_id'),
            dormitoryId: data.parent!.params.getInt('dorm_id'),
          ),
          children: [
            NamedRouteDef(
              name: 'MasterHomeTab',
              builder: (_, data) {
                final rootParams =
                    data.parent?.parent?.params ?? data.parent!.params;
                return RepairRequestScreen(
                  specId: rootParams.getInt('spec_id'),
                  dormId: rootParams.getInt('dorm_id'),
                );
              },
            ),
            NamedRouteDef(
              name: 'MaterialTab',
              builder: (_, _) => const MaterialScreen(),
            ),
            NamedRouteDef(
              name: 'ProfileTab',
              builder: (_, _) => const ProfileScreen(),
            ),
          ],
        ),
        NamedRouteDef(
          name: 'MaterialDetails',
          builder: (_, data) {
            final material = data.params.get('material');
            return MaterialDetails(material: material);
          },
        ),
        NamedRouteDef(
          name: 'MasterRequestDetails',
          builder: (_, data) {
            final request = data.params.get('request');
            return MasterRequestDetails(request: request);
          },
        ),
        NamedRouteDef(
          name: 'AcceptRequestScreen',
          builder: (_, data) {
            return AcceptRequestScreen(
              requestId: data.params.get('request_id'),
            );
          },
        ),
      ],
    ),
  ];
}

const List<AppPage> studentPages = <AppPage>[
  AppPage(name: 'StudentHomeTab', title: 'Домашняя', icon: UiIcons.home),
  AppPage(name: 'FormRequestTab', title: 'Заявка', icon: UiIcons.filePlus),
  AppPage(name: 'ProfileTab', title: 'Профиль', icon: UiIcons.userProfile),
];

const List<AppPage> masterPages = <AppPage>[
  AppPage(name: 'MasterHomeTab', title: 'Домашняя', icon: UiIcons.home),
  AppPage(name: 'MaterialTab', title: 'Материалы', icon: UiIcons.clock),
  AppPage(name: 'ProfileTab', title: 'Профиль', icon: UiIcons.userProfile),
];

class AuthGuard extends AutoRouteGuard {
  final AuthBloc authBloc;

  AuthGuard(this.authBloc);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = authBloc.state;
    state.mapOrNull(
      initial: (_) => resolver.next(true),
      authenticated: (_) => resolver.next(true),
      notAuthenticated: (_) =>
          resolver.redirectUntil(const NamedRoute('SignIn')),
      error: (_) => resolver.redirectUntil(const NamedRoute('SignIn')),
    );
  }
}
