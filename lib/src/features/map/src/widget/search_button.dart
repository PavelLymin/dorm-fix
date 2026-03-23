import 'package:ui_kit/ui.dart';

import 'map_search.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => showUiBottomSheet(
      context,
      title: 'Выбор общежития',
      widget: const SearchSheet(),
    ),
    child: UiTextField.standard(
      enabled: false,
      style: const .new(hintText: 'Поиск общежитий...'),
    ),
  );
}
