import 'package:dorm_fix/l10n/gen/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../material/material.dart';
import '../../../../repair_request/request.dart';

class AcceptRequestScreen extends StatefulWidget {
  const AcceptRequestScreen({super.key, required this.requestId});

  final int requestId;

  @override
  State<AcceptRequestScreen> createState() => _AcceptRequestScreenState();
}

class _AcceptRequestScreenState extends State<AcceptRequestScreen> {
  late final MaterialsUsedController _materialsNotifier;
  late final RepairActionBloc _repairActionBloc;

  @override
  void initState() {
    super.initState();
    _materialsNotifier = MaterialsUsedController({});
    final dependency = DependeciesScope.of(context);
    _repairActionBloc = RepairActionBloc(
      requestRepository: dependency.requestRepository,
      problemRepository: dependency.problemRepository,
      logger: dependency.logger,
    );
  }

  @override
  void dispose() {
    _materialsNotifier.dispose();
    _repairActionBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Завершить заявку')),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .stretch,
            mainAxisSize: .min,
            children: [
              Padding(
                padding: const .only(top: 24.0, bottom: 10.0),
                child: UiText2.lBold(local.select_materials_used),
              ),
              _AddedMaterials(materialsNotifier: _materialsNotifier),
              UiButton.filledSecondary(
                onPressed: () => showUiBottomSheet(
                  context,
                  spacing: .0,
                  title: local.material_selection,
                  widget: SelectionMaterialsScreen(
                    materialsNotifier: _materialsNotifier,
                  ),
                ),
                label: Text(local.select_materials),
              ),
              const Spacer(),
              BlocProvider.value(
                value: _repairActionBloc,
                child: _CompleteButton(
                  requestId: widget.requestId,
                  materialsNotifier: _materialsNotifier,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddedMaterials extends StatelessWidget {
  const _AddedMaterials({required this.materialsNotifier});

  final MaterialsUsedController materialsNotifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: materialsNotifier,
      builder: (_, _) {
        if (materialsNotifier.value.isNotEmpty) {
          return Padding(
            padding: const .only(bottom: 20.0),
            child: UiCard.standart(
              child: Column(
                children: materialsNotifier.value.entries
                    .map(
                      (material) => Row(
                        mainAxisAlignment: .spaceBetween,
                        crossAxisAlignment: .center,
                        children: [
                          UiText2.m(material.value.name),
                          UiText2.m(material.value.quantity.toString()),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}

class _CompleteButton extends StatelessWidget {
  const _CompleteButton({
    required this.requestId,
    required this._materialsNotifier,
  });
  final int requestId;
  final MaterialsUsedController _materialsNotifier;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return UiButton.filledSecondary(
      onPressed: () {
        context.read<RepairActionBloc>().add(
          .complete(
            requestId: requestId,
            materialUsage: _materialsNotifier.value.map(
              (key, value) => MapEntry(key, value.quantity),
            ),
          ),
        );
      },
      label: ListenableBuilder(
        listenable: _materialsNotifier,
        builder: (context, child) {
          if (_materialsNotifier.value.isNotEmpty) return Text(local.finish);
          return Text(local.repair_without_materials);
        },
      ),
    );
  }
}
