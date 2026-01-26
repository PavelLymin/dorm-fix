import 'package:ui_kit/ui.dart';

class SelectItemsController<T extends Enum> extends ValueNotifier<T> {
  SelectItemsController(
    super.value, {
    required this.selectItems,
    required this.onTap,
  });

  final SelectItem<T> selectItems;
  void Function() onTap;

  List<GroupedListItem> createItems() => selectItems.items.entries.map((e) {
    bool isSelected = value == e.value;
    return GroupedListItem(
      title: UiText.bodyMedium(e.key),
      onTap: () {
        value = e.value;
        selectItems.onChange?.call(value);
        onTap.call();
      },
      content: isSelected
          ? const Icon(Icons.check_circle_outline, size: 18.0)
          : null,
      isSelected: isSelected,
    );
  }).toList();
}
