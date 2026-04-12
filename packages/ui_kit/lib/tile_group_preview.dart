import 'package:ui_kit/ui.dart';

class TileGroupPreview extends StatelessWidget {
  const TileGroupPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return TileGroup(
      items: [
        TileGroupItem(
          prefixIcon: Icon(Icons.email_outlined),
          title: 'Адрес электронной почты',
          onTap: () {},
        ),
        TileGroupItem(
          prefixIcon: Icon(Icons.phone_rounded),
          title: 'Номер телефона',
          onTap: () {},
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
