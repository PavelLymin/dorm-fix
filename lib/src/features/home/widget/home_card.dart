import 'package:ui_kit/ui.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final Image icon;
  final Widget title;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) => UiCard.clickable(
    onTap: () {},
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        const SizedBox(width: 16),
        Flexible(
          child: ListTile(
            title: title,
            subtitle: Padding(
              padding: AppPadding.onlyIncrement(top: 1),
              child: subtitle,
            ),
          ),
        ),
      ],
    ),
  );
}
