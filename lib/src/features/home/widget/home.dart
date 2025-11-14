import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../../../app/widget/dependencies_scope.dart';
import '../../profile/student/state_management/bloc/student_bloc.dart';
import 'carousel.dart';
import 'home_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    return Scaffold(
      body: WindowSizeScope.of(context).maybeMap(
        orElse: () => Padding(
          padding: AppPadding.symmetricIncrement(horizontal: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(title: const _UserDisplayProfile(), centerTitle: false),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SpecializationsCarousel(),
                    const SizedBox(height: 8),
                    HomeCard(
                      icon: Image.asset(
                        ImagesHelper.request,
                        height: 32,
                        width: 32,
                      ),
                      title: UiText.titleMedium('Создать заявку'),
                      subtitle: UiText.bodyLarge(
                        'Данный поиск осуществляется по тексту, вводимый пользователем ',
                        style: TextStyle(color: colorPalette.mutedForeground),
                      ),
                    ),
                    const SizedBox(height: 8),
                    HomeCard(
                      icon: Image.asset(
                        ImagesHelper.history,
                        height: 32,
                        width: 32,
                      ),
                      title: UiText.titleMedium('История завок'),
                      subtitle: UiText.bodyLarge(
                        'Данный поиск осуществляется по тексту, вводимый пользователем ',
                        style: TextStyle(color: colorPalette.mutedForeground),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserDisplayProfile extends StatefulWidget {
  const _UserDisplayProfile();

  @override
  State<_UserDisplayProfile> createState() => __UserDisplayProfileState();
}

class __UserDisplayProfileState extends State<_UserDisplayProfile> {
  late StudentBloc _studentBloc;

  @override
  void initState() {
    super.initState();
    final authUser = DependeciesScope.of(
      context,
    ).authenticationBloc.state.authenticatedOrNull;
    if (authUser != null) {
      _studentBloc = DependeciesScope.of(context).studentBloc
        ..add(StudentEvent.get(uid: authUser.uid));
    }
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _studentBloc,
    child: BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(),
          ),
          loaded: (state) =>
              UiText.headlineLarge(state.student.user.displayName!),
          error: (state) => UiText.headlineLarge(state.message),
        );
      },
    ),
  );
}
