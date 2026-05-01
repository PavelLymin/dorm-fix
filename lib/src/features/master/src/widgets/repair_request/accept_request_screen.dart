import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../../../../../app/widget/dependencies_scope.dart';
import '../../../../material/material.dart';
import 'selection_materials_screen.dart';

class AcceptRequestScreen extends StatefulWidget {
  const AcceptRequestScreen({super.key});

  @override
  State<AcceptRequestScreen> createState() => _AcceptRequestScreenState();
}

class _AcceptRequestScreenState extends State<AcceptRequestScreen> {
  late final MaterialsUsedController _materialsNotifier;
  late final MaterialBloc _materialBloc;
  late final MaterialTypeBloc _materialTypeBloc;

  @override
  void initState() {
    super.initState();
    _materialsNotifier = MaterialsUsedController({});
    final dependency = DependeciesScope.of(context);
    _materialTypeBloc = MaterialTypeBloc(
      materialTypeRepository: dependency.materialTypeRepository,
      logger: dependency.logger,
    )..add(MaterialTypeEvent.get());
    _materialBloc = MaterialBloc(
      materialRepository: dependency.materialRepository,
      logger: dependency.logger,
    )..add(MaterialEvent.get());
  }

  @override
  void dispose() {
    _materialsNotifier.dispose();
    _materialTypeBloc.close();
    _materialBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: UiText2.lBold('Выберите использованные материалы'),
              ),
              _AddedMaterials(materialsNotifier: _materialsNotifier),
              UiButton.filledSecondary(
                onPressed: () => showUiBottomSheet(
                  context,
                  spacing: .0,
                  title: 'Выбор материалов',
                  widget: MultiBlocProvider(
                    providers: [
                      BlocProvider.value(value: _materialTypeBloc),
                      BlocProvider.value(value: _materialBloc),
                    ],
                    child: SelectionMaterialsScreen(
                      materialsNotifier: _materialsNotifier,
                    ),
                  ),
                ),
                label: Text('Выбрать материалы'),
              ),
              const Spacer(),
              UiButton.filledSecondary(
                onPressed: () {},
                label: Text('Ремонт без материалов'),
              ),
              const SizedBox(height: 16.0),
              UiButton.filledPrimary(
                onPressed: () {},
                label: Text('Завершить'),
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
                          UiText2.m(material.value.$1),
                          UiText2.m(material.value.$2.toString()),
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
