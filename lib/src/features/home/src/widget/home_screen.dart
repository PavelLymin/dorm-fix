import 'package:ui_kit/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../profile/profile.dart';
import '../../home.dart';
import 'carousel.dart';
import 'home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with _HomeScreenStateMixin {
  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _specializationBloc,
    child: Scaffold(body: const Center(child: _HomeBody())),
  );
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final window = WindowSizeScope.of(context);
    final windowWidth = MediaQuery.sizeOf(context).width;
    return SafeArea(
      child: SizedBox(
        width: window.maybeMap(
          orElse: () => windowWidth * 0.6,
          medium: (_) => windowWidth * 0.8,
          compact: (_) => windowWidth * 0.9,
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Padding(
              padding: AppPadding.onlyIncrement(top: 2),
              child: const _UserDisplayProfile(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .center,
                children: [
                  const SpecializationsCarousel(),
                  const SizedBox(height: 8),
                  window.isLarge
                      ? const Row(
                          mainAxisSize: .min,
                          spacing: 8,
                          children: [
                            Expanded(child: HomeCard.request()),
                            Expanded(child: HomeCard.history()),
                          ],
                        )
                      : const Column(
                          spacing: 8,
                          children: [HomeCard.request(), HomeCard.history()],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserDisplayProfile extends StatelessWidget {
  const _UserDisplayProfile();

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      return state.maybeMap(
        orElse: () => const SizedBox.shrink(),
        loading: (_) => const SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(),
        ),
        loadedStudent: (state) {
          final student = state.student;
          return Column(
            spacing: 4,
            crossAxisAlignment: .start,
            children: [
              UiText.headlineLarge(
                student.user.displayName!,
                style: TextStyle(color: Theme.of(context).colorPalette.primary),
              ),
              UiText.headlineLarge(student.dormitory.name),
              UiText.headlineLarge(student.room.number),
            ],
          );
        },
        error: (state) => UiText.headlineLarge(state.message),
      );
    },
  );
}

mixin _HomeScreenStateMixin on State<HomeScreen> {
  late final SpecializationBloc _specializationBloc;

  @override
  void initState() {
    super.initState();
    _specializationBloc = DependeciesScope.of(context).specializationBloc
      ..add(.getSpecializations());
  }
}
