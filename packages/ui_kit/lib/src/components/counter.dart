import 'package:flutter/foundation.dart';

import '../../ui.dart';

class UiCounter extends StatelessWidget {
  const UiCounter({
    super.key,
    this.onDecrement,
    this.onIncrement,
    required this.valueListenable,
  });

  final void Function()? onDecrement;
  final void Function()? onIncrement;
  final ValueListenable<int> valueListenable;

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .end,
        mainAxisSize: .min,
        children: [
          UiButton.icon(
            style: ButtonStyle(
              padding: .all(.zero),
              minimumSize: .all(.zero),
              tapTargetSize: .shrinkWrap,
            ),
            onPressed: onDecrement,
            icon: const Icon(UiIcons.menu),
          ),
          const Spacer(),
          ValueListenableBuilder<int>(
            valueListenable: valueListenable,
            builder: (context, value, child) =>
                UiText2.m(textAlign: .center, value.toString()),
          ),
          const Spacer(),
          UiButton.icon(
            style: ButtonStyle(
              padding: .all(.zero),
              minimumSize: .all(.zero),
              tapTargetSize: .shrinkWrap,
            ),
            onPressed: onIncrement,
            icon: const Icon(UiIcons.plus),
          ),
        ],
      ),
    );
  }
}
