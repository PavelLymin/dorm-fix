import 'package:ui_kit/ui.dart';

class GroupedListPreview extends StatelessWidget {
  const GroupedListPreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: GroupedList(
      items: [
        GroupedListItem(
          title: 'Адрес электронной почты',
          data: 'email.letter@mail.com',
          onTap: () {},
        ),
        GroupedListItem(
          title: 'Номер телефона',
          data: '+7 123 456 78 90',
          onTap: () {},
        ),
        GroupedListItem(title: 'Общежитие', data: 'Общежитие 30', onTap: () {}),
      ],
    ),
  );
}
