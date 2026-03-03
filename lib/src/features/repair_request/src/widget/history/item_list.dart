import 'package:ui_kit/ui.dart';
import '../../../request.dart';

abstract class EstimatedSizes {
  const EstimatedSizes();

  static EdgeInsets get listPadding => AppPadding.vertical;
  static EdgeInsets get itemPadding =>
      AppPadding.symmetricIncrement(horizontal: 2, vertical: 3);
  static double get spacing => 4.0;
  static double get thickness => 1.0;
  static double get dividerHeight => 32.0;

  static late double heightDescription;

  static TextStyle titleStyle(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return theme.appTypography.bodyMedium.copyWith(color: palette.foreground);
  }

  static double estimateHeightDescription(BuildContext context) {
    final style = titleStyle(context);
    final twoLineText =
        TextPainter(
          text: TextSpan(text: 'text\ntext', style: style),
          maxLines: 2,
          textDirection: .ltr,
        )..layout(
          maxWidth:
              MediaQuery.sizeOf(context).width -
              AppPadding.pagePadding.horizontal,
        );

    return heightDescription = twoLineText.height;
  }

  static double estimateHeight(BuildContext context) {
    final style = titleStyle(context);
    final lineText = TextPainter(
      text: TextSpan(style: style),
      maxLines: 1,
      textDirection: .ltr,
    )..layout();

    return lineText.height * 7 +
        heightDescription +
        spacing * 15 +
        thickness +
        dividerHeight +
        itemPadding.vertical +
        listPadding.vertical;
  }
}

class Item extends StatelessWidget {
  const Item({super.key, required this.request});

  final FullRepairRequest request;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    return UiCard.standart(
      borderRadius: style.borderRadius,
      padding: EstimatedSizes.itemPadding,
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        spacing: EstimatedSizes.spacing,
        children: [
          Text(
            'Заявка №${request.id}',
            style: EstimatedSizes.titleStyle(context),
          ),
          SizedBox(
            height: EstimatedSizes.heightDescription,
            child: Text(
              request.description,
              style: EstimatedSizes.titleStyle(
                context,
              ).copyWith(color: palette.mutedForeground),
              softWrap: true,
              maxLines: 2,
              overflow: .ellipsis,
            ),
          ),
          Divider(
            height: EstimatedSizes.dividerHeight,
            thickness: EstimatedSizes.thickness,
          ),
          Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              _ItemData(
                title: 'Дата',
                value: request.date.toLocal().toString(),
              ),
              _ItemData(title: 'Мастер', value: request.specialization.title),
              _ItemData(title: 'Приоритет', value: request.priority.value),
              _ItemData(
                title: 'Студент отсутствует',
                value: request.studentAbsent ? 'Да' : 'Нет',
              ),
              _ItemData(
                title: 'Время',
                value: '${request.startTime}:00 - ${request.endTime}:00',
              ),
              _ItemStatus(status: request.status),
            ],
          ),
        ],
      ),
    );
  }
}

class _ItemData extends StatelessWidget {
  const _ItemData({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    return Padding(
      padding: .symmetric(vertical: EstimatedSizes.spacing),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        spacing: 64.0,
        children: [
          Text(
            title,
            style: EstimatedSizes.titleStyle(
              context,
            ).copyWith(color: palette.mutedForeground),
          ),
          Flexible(
            child: Text(
              value,
              style: EstimatedSizes.titleStyle(context),
              softWrap: false,
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemStatus extends StatelessWidget {
  const _ItemStatus({required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette;
    final style = theme.appStyleData.style;
    Color statusColor = switch (status) {
      .completed => palette.completed,
      .inProgress => palette.inProgress,
      .newRequest => palette.newRequest,
    };
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .center,
      children: [
        Text(
          'Статус',
          style: EstimatedSizes.titleStyle(
            context,
          ).copyWith(color: palette.mutedForeground),
        ),
        Container(
          width: 128.0,
          padding: .all(EstimatedSizes.spacing),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: style.borderRadius,
          ),
          child: Text(
            status.value,
            textAlign: .center,
            style: EstimatedSizes.titleStyle(context),
            overflow: .ellipsis,
          ),
        ),
      ],
    );
  }
}
