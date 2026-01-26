import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';

enum HomeCardType { request, history }

sealed class HomeCard extends StatelessWidget {
  const HomeCard._({
    required this.title,
    required this.subtitle,
    required this.type,
  });

  final String title;
  final String subtitle;
  final HomeCardType type;

  const factory HomeCard.request() = HomeCardRequest;

  const factory HomeCard.history() = HomeCardHistory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.contentPadding,
      child: UiCard.clickable(
        padding: AppPadding.symmetricIncrement(vertical: 3, horizontal: 2),
        onTap: () => switch (type) {
          .request => context.router.push(const NamedRoute('RequestScreen')),
          .history => context.router.pushPath(''),
        },
        child: Column(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .start,
          mainAxisSize: .min,
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
      ),
    );
  }
}

final class HomeCardRequest extends HomeCard {
  const HomeCardRequest()
    : super._(
        title: 'Создать заявку',
        subtitle:
            'Данный поиск осуществляется по тексту, вводимый пользователем',
        type: .request,
      );
}

final class HomeCardHistory extends HomeCard {
  const HomeCardHistory()
    : super._(
        title: 'История заявок',
        subtitle:
            'Данный поиск осуществляется по тексту, вводимый пользователем ',
        type: .history,
      );
}
