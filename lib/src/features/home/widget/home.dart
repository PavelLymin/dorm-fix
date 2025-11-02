import 'package:dorm_fix/src/app/widget/dependencies_scope.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../state_management/bloc/specialization_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CarouselController _controller = CarouselController();
  List<Widget> children = [];
  late SpecializationBloc _specializationBloc;

  @override
  void initState() {
    super.initState();
    _specializationBloc = DependeciesScope.of(context).specializationBloc;
    _specializationBloc.add(SpecializationEvent.getSpecializations());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _specializationBloc,
    child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              child: BlocBuilder<SpecializationBloc, SpecializationState>(
                builder: (context, state) {
                  return CarouselView(
                    itemClipBehavior: Clip.none,
                    shrinkExtent: 100,
                    itemExtent: double.infinity,
                    itemSnapping: true,
                    controller: _controller,
                    children: state.map(
                      loading: (_) => List.filled(
                        3,
                        const SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      loaded: (state) => state.specializations
                          .map(
                            (spec) => Padding(
                              padding: const EdgeInsets.all(27.0),
                              child: UiCard(
                                child: Center(
                                  child: UiText.bodyLarge(
                                    spec.name,
                                    softWrap: false,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      error: (state) => List.filled(
                        3,
                        UiCard(
                          child: Center(
                            child: UiText.bodyLarge(
                              state.message,
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
