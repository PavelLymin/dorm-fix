import 'dart:async';

import 'package:ui_kit/ui.dart';

class SelectItemsController extends ValueNotifier<Enum> {
  SelectItemsController(
    super.value, {
    required this.selectItems,
    required this.onTap,
  });

  final GroupedListSelection selectItems;
  final FutureOr<void> Function() onTap;

  List<GroupedListItem> createItems() => selectItems.items.entries.map((e) {
    final isSelected = value == e.key;
    return GroupedListItem(
      title: UiText.bodyMedium(e.value),
      onTap: () async {
        value = e.key;
        await selectItems.onSelect(e.key);
        await onTap();
      },
      content: isSelected
          ? const Icon(Icons.check_circle_outline, size: 18.0)
          : null,
      isSelected: isSelected,
    );
  }).toList();
}
