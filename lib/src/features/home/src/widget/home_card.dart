import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';

enum HomeCardType { request, history }

class HomeCard extends StatelessWidget {
  const HomeCard._({
    required this.title,
    required this.subtitle,
    required this.type,
  });

  final String title;
  final String subtitle;
  final HomeCardType type;

  factory HomeCard.request() => HomeCard._(
    title: 'Создать заявку',
    subtitle: 'Данный поиск осуществляется по тексту, вводимый пользователем',
    type: .request,
  );

  factory HomeCard.history() => HomeCard._(
    title: 'История заявок',
    subtitle: 'Данный поиск осуществляется по тексту, вводимый пользователем ',
    type: .history,
  );

  @override
  Widget build(BuildContext context) {
    return UiCard.clickable(
      padding: AppPadding.onlyIncrement(top: 3, bottom: 5, left: 2, right: 2),
      onTap: () => switch (type) {
        .request => context.router.push(const NamedRoute('RequestScreen')),
        .history => context.router.pushPath(''),
      },
      child: Column(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: 0.0,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            mainAxisSize: .max,
            children: [
              UiText.bodyLarge(title, style: TextStyle(fontWeight: .w600)),
              UiButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chevron_right_outlined),
              ),
            ],
          ),
          UiText.bodyLarge(subtitle),
        ],
      ),
    );
  }
}
