import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../../l10n/gen/app_localizations.dart';
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
    final local = AppLocalizations.of(context);
    final status = widget.request.currentStatus;
    return BlocProvider.value(
      value: _repairActionBloc,
      child: Scaffold(
        appBar: AppBar(title: Text(local.application)),
        body: SafeArea(
          child: Padding(
            padding: AppInsets.screen,
            child: CustomScrollView(
              slivers: [
                if (widget.request.problems.isNotEmpty)
                  RequestImages(problems: widget.request.problems),
                SliverPadding(
                  padding: .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold(local.details),
                  ),
                ),
                RequestDetails(request: widget.request),
                SliverPadding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold(local.description),
                  ),
                ),
                SliverToBoxAdapter(
                  child: UiCard.standart(
                    child: UiText2.m(widget.request.description),
                  ),
                ),
                SliverPadding(
                  padding: const .only(top: 24.0, bottom: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: UiText2.lBold(local.repair_date_time),
                  ),
                ),
                RequestDateTime(request: widget.request),
                if (status == .inProgress || status == .newRequest)
                  _AcceptCancelButton(
                    id: widget.request.id,
                    status: widget.request.currentStatus,
                  ),
                if (widget.request.currentStatus == .inProgress)
                  _CancelButton(
                    id: widget.request.id,
                    status: widget.request.currentStatus,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AcceptCancelButton extends StatelessWidget {
  const _AcceptCancelButton({required this.id, required this.status});

  final int id;
  final StatusEnum status;

  void onPressed(BuildContext context) {
    if (status == .inProgress) {
      context.router.push(
        NamedRoute('AcceptRequestScreen', params: {'request_id': id}),
      );
    } else {
      context.read<RepairActionBloc>().add(.accept(requestId: id));
      context.router.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return SliverPadding(
      padding: .only(top: 32.0),
      sliver: SliverToBoxAdapter(
        child: UiButton.filledPrimary(
          onPressed: () => onPressed(context),
          label: status == .inProgress
              ? Text(local.finish_application)
              : Text(local.accept_application),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.id, required this.status});

  final int id;
  final StatusEnum status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return SliverPadding(
      padding: const .only(top: 16.0),
      sliver: SliverToBoxAdapter(
        child: UiButton.filledSecondary(
          onPressed: () => context.read<RepairActionBloc>().add(
            .updateStatus(id: id, status: .canceled),
          ),
          label: Text(
            AppLocalizations.of(context).cancel_application,
            style: TextStyle(color: palette.destructive),
          ),
        ),
      ),
    );
  }
}
