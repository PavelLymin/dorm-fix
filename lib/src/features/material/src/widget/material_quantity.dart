import 'package:ui_kit/ui.dart';

import '../../../../../l10n/gen/app_localizations.dart';
import '../../material.dart';

class MaterialQuantity extends StatefulWidget {
  const MaterialQuantity({super.key, required this.material});

  final MaterialEntity material;

  @override
  State<MaterialQuantity> createState() => _MaterialQuantityState();
}

class _MaterialQuantityState extends State<MaterialQuantity> {
  late final MaterialQuantityNotifier _controller;

  @override
  void initState() {
    super.initState();
    _controller = MaterialQuantityNotifier(
      0,
      maxQuantity: widget.material.quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      mainAxisSize: .min,
      spacing: 10.0,
      children: [
        Padding(
          padding: const .only(top: 20.0),
          child: UiText2.lBold(locale.specify_quantity),
        ),
        UiCounter(
          onIncrement: () => _controller.increment(widget.material),
          onDecrement: () => _controller.decrement(widget.material),
          valueListenable: _controller,
        ),
        Padding(
          padding: const .only(top: 20.0, bottom: 10.0),
          child: UiButton.filledPrimary(
            onPressed: () {},
            label: Text(locale.save),
          ),
        ),
      ],
    );
  }
}
