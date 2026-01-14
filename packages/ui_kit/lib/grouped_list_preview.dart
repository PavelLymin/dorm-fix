import 'package:ui_kit/ui.dart';

class GroupedListPreview extends StatelessWidget {
  const GroupedListPreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: GroupedList<SampleEnum>(
      items: [
        GroupedListItem(
          prefixIcon: Icons.email_outlined,
          title: 'Адрес электронной почты',
          data: 'email.letter@mail.com',
          onTap: () {},
          content: const Icon(Icons.arrow_forward),
        ),
        GroupedListItem(
          prefixIcon: Icons.phone_rounded,
          title: 'Номер телефона',
          data: '+7 123 456 78 90',
          onTap: () {},
          content: const Icon(Icons.arrow_forward),
          selectItems: SelectItem<SampleEnum>(
            items: {
              'Option 1': .option1,
              'Option 2': .option2,
              'Option 3': .option3,
            },
            initial: .option2,
          ),
        ),
        GroupedListItem(
          title: 'Общежитие',
          data: 'Общежитие 30',
          onTap: () {},
          content: const Icon(Icons.arrow_forward),
          selectItems: SelectItem<SampleEnum>(
            items: {
              'Option 1': .option1,
              'Option 2': .option2,
              'Option 3': .option3,
            },
            initial: .option1,
            onChange: (value) => print(value),
          ),
        ),
      ],
    ),
  );
}

enum SampleEnum {
  option1('option1'),
  option2('option2'),
  option3('option3');

  const SampleEnum(this.value);

  final String value;
}
