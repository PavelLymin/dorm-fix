import 'package:ui_kit/ui.dart';

class GroupedListPreview extends StatelessWidget {
  const GroupedListPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      color: Colors.amber,
      // child: GroupedList(
      //   divider: .indented(),
      //   items: [
      //     GroupedListItem(
      //       prefixIcon: const Icon(Icons.email_outlined),
      //       title: UiText.bodyMedium('Адрес электронной почты'),
      //       onTap: () {},
      //       content: const Icon(Icons.arrow_forward),
      //     ),
      //     GroupedListItem(
      //       prefixIcon: Icon(Icons.phone_rounded),
      //       title: UiText.bodyMedium('Номер телефона'),
      //       onTap: () {},
      //       content: const Icon(Icons.arrow_forward),
      //       selectItems: SelectItem<SampleEnum>(
      //         items: {
      //           .option1: 'Option 1',
      //           .option2: 'Option 2',
      //           .option3: 'Option 3',
      //         },
      //         initial: .option2,
      //       ),
      //     ),
      //     GroupedListItem(
      //       title: UiText.bodyMedium('Общежитие'),
      //       content: const Icon(Icons.arrow_forward),
      //       selectItems: SelectItem<SampleEnum>(
      //         items: {
      //           .option1: 'Option 1',
      //           .option2: 'Option 2',
      //           .option3: 'Option 3',
      //         },
      //         initial: .option1,
      //         onChange: (value) {},
      //       ),
      //     ),
      //   ],
      // ),
      child: TileGroup(
        items: [
          TileGroupItem(
            prefixIcon: Icon(Icons.email_outlined),
            title: 'Адрес электронной почты',
          ),
          TileGroupItem(
            prefixIcon: Icon(Icons.phone_rounded),
            title: 'Номер телефона',
          ),
          TileGroupItem(
            prefixIcon: Icon(Icons.apartment_outlined),
            title: 'Общежитие',
            initial: 0,
            onTap: () {},
            selectItem: TileSelectItem(
              items: {0: 'Option 1', 1: 'Option 2', 2: 'Option 3'},
              onSelect: (p0) => debugPrint('Selected: $p0'),
            ),
          ),
        ],
      ),
    );
  }
}

enum SampleEnum {
  option1('option1'),
  option2('option2'),
  option3('option3');

  const SampleEnum(this.value);

  final String value;
}
