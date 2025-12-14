import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';

enum HomeCardType { request, history }

sealed class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.nameImage,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  final String nameImage;
  final String title;
  final String subtitle;
  final HomeCardType type;

  const factory HomeCard.request() = RequestCard;
  const factory HomeCard.history() = HistoryCard;

  @override
  Widget build(BuildContext context) {
    final colorPalette = Theme.of(context).colorPalette;
    final isLarge = WindowSizeScope.of(context).isLargeOrLarger;
    return SizedBox(
      height: isLarge ? 208 : null,
      child: UiCard.clickable(
        onTap: () => switch (type) {
          HomeCardType.request => context.pushRoute(
            NamedRoute('RequestScreen'),
          ),
          HomeCardType.history => context.pushRoute(
            NamedRoute('HistoryScreen'),
          ),
        },
        child: Row(
          crossAxisAlignment: .center,
          mainAxisAlignment: .start,
          children: [
            Image.asset(
              nameImage,
              height: isLarge ? 64 : 32,
              width: isLarge ? 64 : 32,
            ),
            const SizedBox(width: 16),
            Flexible(
              child: ListTile(
                title: isLarge
                    ? UiText.headlineLarge(title)
                    : UiText.titleMedium(title),
                subtitle: Padding(
                  padding: AppPadding.onlyIncrement(top: isLarge ? 2 : 1),
                  child: isLarge
                      ? UiText.headlineSmall(
                          subtitle,
                          style: TextStyle(color: colorPalette.mutedForeground),
                        )
                      : UiText.bodyLarge(
                          subtitle,
                          style: TextStyle(color: colorPalette.mutedForeground),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class RequestCard extends HomeCard {
  const RequestCard({
    super.key,
    super.type = HomeCardType.request,
    super.nameImage = ImagesHelper.request,
    super.title = 'Создать заявку',
    super.subtitle =
        'Данный поиск осуществляется по тексту, вводимый пользователем',
  });
}

final class HistoryCard extends HomeCard {
  const HistoryCard({
    super.key,
    super.type = HomeCardType.history,
    super.nameImage = ImagesHelper.history,
    super.title = 'История заявок',
    super.subtitle =
        'Данный поиск осуществляется по тексту, вводимый пользователем ',
  });
}
