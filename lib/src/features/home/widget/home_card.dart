import 'package:ui_kit/ui.dart';

enum HomeCardType { request, history }

sealed class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.nameImage,
    required this.title,
    required this.subtitle,
    this.type = HomeCardType.request,
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
    return UiCard.clickable(
      onTap: () {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(nameImage, height: 32, width: 32),
          const SizedBox(width: 16),
          Flexible(
            child: ListTile(
              title: UiText.titleMedium(title),
              subtitle: Padding(
                padding: AppPadding.onlyIncrement(top: 1),
                child: UiText.bodyLarge(
                  subtitle,
                  style: TextStyle(color: colorPalette.mutedForeground),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class RequestCard extends HomeCard {
  const RequestCard({
    super.key,
    super.nameImage = ImagesHelper.request,
    super.title = 'Создать заявку',
    super.subtitle =
        'Данный поиск осуществляется по тексту, вводимый пользователем',
  }) : super(type: HomeCardType.request);
}

final class HistoryCard extends HomeCard {
  const HistoryCard({
    super.key,
    super.nameImage = ImagesHelper.history,
    super.title = 'История заявок',
    super.subtitle =
        'Данный поиск осуществляется по тексту, вводимый пользователем ',
  }) : super(type: HomeCardType.history);
}
