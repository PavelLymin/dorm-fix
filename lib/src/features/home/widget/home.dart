import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../app/widget/dependencies_scope.dart';
import '../../profile/bloc/student_bloc.dart';
import '../state_management/bloc/specialization_bloc.dart';
import 'carousel.dart';
import 'home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StudentBloc _studentBloc;
  late SpecializationBloc _specializationBloc;

  @override
  void initState() {
    super.initState();
    _studentBloc = DependeciesScope.of(context).studentBloc
      ..add(StudentEvent.get());
    final specializationRepository = DependeciesScope.of(
      context,
    ).specializationRepository;
    final logger = DependeciesScope.of(context).logger;
    _specializationBloc = SpecializationBloc(
      specializationRepository: specializationRepository,
      logger: logger,
    )..add(SpecializationEvent.getSpecializations());
  }

  @override
  void dispose() {
    _studentBloc.close();
    _specializationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _studentBloc),
      BlocProvider.value(value: _specializationBloc),
    ],
    child: Scaffold(body: const Center(child: _HomeBody())),
  );
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final window = WindowSizeScope.of(context);
    final windowWidth = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: window.maybeMap(
        orElse: () => windowWidth * 0.7,
        compact: (_) => windowWidth * 0.9,
      ),
      child: Column(
        children: [
          AppBar(title: const _UserDisplayProfile(), centerTitle: false),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SpecializationsCarousel(),
                const SizedBox(height: 8),
                window.isLarge
                    ? const Row(
                        mainAxisSize: MainAxisSize.min,
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
    );
  }
}

class _UserDisplayProfile extends StatelessWidget {
  const _UserDisplayProfile();

  @override
  Widget build(BuildContext context) => BlocBuilder<StudentBloc, StudentState>(
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
  );
}
