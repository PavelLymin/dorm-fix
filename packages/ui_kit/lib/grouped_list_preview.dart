import 'package:ui_kit/ui.dart';

class GroupedListPreview extends StatelessWidget {
  const GroupedListPreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Padding(
      padding: AppPadding.allSmall,
      child: GroupedList(
        items: [
          GroupedListItem(
            title: UiText.labelLarge('Адрес электронной почты'),
            data: UiText.bodyMedium('email.letter@mail.com'),
            onTap: () {},
          ),
          GroupedListItem(
            title: UiText.labelLarge('Номер телефона'),
            data: UiText.bodyMedium('+7 123 456 78 90'),
            onTap: () {},
          ),
          GroupedListItem(
            title: UiText.labelLarge('Общежитие'),
            data: UiText.bodyMedium('Общежитие 30'),
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}
