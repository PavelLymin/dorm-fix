import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../repair_request/request.dart';

class MasterRequestDetails extends StatefulWidget {
  const MasterRequestDetails({super.key, required this.request});

  final FullRepairRequest request;

  @override
  State<MasterRequestDetails> createState() => _MasterRequestDetailsState();
}

class _MasterRequestDetailsState extends State<MasterRequestDetails> {
  late final RepairActionBloc _repairActionBloc;
  @override
  void initState() {
    super.initState();
    final dependency = DependeciesScope.of(context);
    _repairActionBloc = RepairActionBloc(
      requestRepository: dependency.requestRepository,
      problemRepository: dependency.problemRepository,
      logger: dependency.logger,
    );
  }

  @override
  void dispose() {
    _repairActionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.request.currentStatus.value);
    return BlocProvider.value(
      value: _repairActionBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Заявка')),
        body: SafeArea(
          child: Padding(
            padding: AppInsets.screen,
            child: CustomScrollView(
              slivers: [
                if (widget.request.problems.isNotEmpty)
                  RequestImages(problems: widget.request.problems),
                SliverPadding(
                  padding: .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(child: UiText2.lBold('Детали')),
                ),
                RequestDetails(request: widget.request),
                SliverPadding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(child: UiText2.lBold('Описание')),
                ),
                SliverToBoxAdapter(
                  child: UiCard.standart(
                    child: UiText2.m(widget.request.description),
                  ),
                ),
                SliverPadding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold('Дата и время ремонта'),
                  ),
                ),
                RequestDateTime(request: widget.request),
                _Button(requestId: widget.request.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.requestId});

  final int requestId;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: .only(top: 32.0),
      sliver: SliverToBoxAdapter(
        child: UiButton.filledPrimary(
          onPressed: () => context.read<RepairActionBloc>().add(
            .accept(requestId: requestId),
          ),
          label: const Text('Принять заявку'),
        ),
      ),
    );
  }
}
