import 'package:dorm_fix/src/features/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../app/widget/dependencies_scope.dart';
import '../../../dormitory/dormitory.dart';
import '../../../master/master.dart';
import '../../specialization.dart';

class SpecializationScreen extends StatefulWidget {
  const SpecializationScreen({super.key, required this.specialization});

  final SpecializationEntity specialization;

  @override
  State<SpecializationScreen> createState() => _SpecializationScreenState();
}

class _SpecializationScreenState extends State<SpecializationScreen> {
  late final MasterBloc _masterBloc;
  late int? dormId;

  @override
  void initState() {
    super.initState();
    dormId = context.read<AuthBloc>().state.profileUserOrNull?.dormitory.id;
    final dependency = DependeciesScope.of(context);
    _masterBloc = MasterBloc(
      repository: dependency.masterRepository,
      logger: dependency.logger,
    )..add(.get(dormId: dormId, specId: widget.specialization.id));
  }

  @override
  void dispose() {
    _masterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _masterBloc,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: UiCard.standart(
              padding: const .only(
                left: 20.0,
                top: 12.0,
                right: 20.0,
                bottom: 16.0,
              ),
              child: UiText2.m(widget.specialization.description),
            ),
          ),
          SliverPadding(
            padding: const .only(top: 24.0, bottom: 10.0),
            sliver: SliverToBoxAdapter(child: UiText2.lBold('Список мастеров')),
          ),
          SliverToBoxAdapter(
            child: DropDownDormitories(
              initialId: dormId,
              onSelected: (id) => _masterBloc.add(
                .get(dormId: id, specId: widget.specialization.id),
              ),
            ),
          ),
          SliverPadding(padding: .only(top: 16.0), sliver: const MasterList()),
        ],
      ),
    );
  }
}
