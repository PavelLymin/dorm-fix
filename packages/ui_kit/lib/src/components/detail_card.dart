import 'package:ui_kit/ui.dart';

class UiDetailCard<T extends Enum> extends StatelessWidget {
  const UiDetailCard({
    super.key,
    required this.statusText,
    required this.status,
    required this.colors,
    required this.title,
    required this.subTitle1,
    this.subTitle2,
    this.style,
    this.images,
    this.imageStyle,
    this.onTap,
  });

  final String statusText;
  final T status;
  final Map<T, Color> colors;
  final List<String>? images;
  final String title;
  final String subTitle1;
  final String? subTitle2;
  final DetailCardStyle? style;
  final ImageStyle? imageStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final colorCard = style?.color ?? palette.card;
    final borderWidth = images != null && images!.isNotEmpty ? 4.0 : 0.0;
    return UiCard.clickable(
      onTap: onTap,
      color: colorCard,
      padding:
          style?.padding ??
          .only(left: 20.0, top: 20.0 - borderWidth, right: 20.0, bottom: 16.0),
      borderRadius: style?.borderRadius,
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .start,
            children: [
              UiStatusIndicator(
                text: statusText,
                value: status,
                colors: colors,
              ),
              if (images != null && images!.isNotEmpty)
                _ImageDetail(
                  images: images!,
                  style: imageStyle ?? const ImageStyle(),
                  colorCard: colorCard,
                  borderWidth: borderWidth,
                ),
            ],
          ),
          SizedBox(height: 12.0 - borderWidth),
          UiText2.lBold(
            title,
            maxLines: 2,
            overflow: .ellipsis,
            style: style?.titleStyle,
          ),
          const SizedBox(height: 6.0),

          if (subTitle2 != null)
            UiText2.m(
              subTitle2!,
              style: TextStyle(
                color: palette.foregroundSecondary,
              ).merge(style?.subTitleStyle),
            ),
          Row(
            mainAxisAlignment: .spaceBetween,
            crossAxisAlignment: .center,
            children: [
              UiText2.m(
                subTitle1,
                style: TextStyle(
                  color: palette.foregroundSecondary,
                ).merge(style?.subTitleStyle),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImageDetail extends StatelessWidget {
  const _ImageDetail({
    required this.images,
    required this.style,
    required this.colorCard,
    required this.borderWidth,
  });

  final List<String> images;
  final ImageStyle style;
  final Color colorCard;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: .none,
      alignment: .center,
      children: [
        Positioned(
          left: -24.0,
          child: _Image(
            path: images.last,
            colorCard: colorCard,
            style: style,
            withBorder: true,
            borderWidth: borderWidth,
          ),
        ),
        if (images.length > 1)
          _Image(
            path: images.first,
            colorCard: colorCard,
            style: style,
            withBorder: true,
            borderWidth: borderWidth,
          ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.path,
    required this.style,
    required this.colorCard,
    required this.borderWidth,
    this.withBorder = false,
  });

  final String path;
  final ImageStyle style;
  final bool withBorder;
  final Color colorCard;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: withBorder ? style.height + borderWidth * 2 : style.height,
      width: withBorder ? style.width + borderWidth : style.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: style.borderRadius,
          border: withBorder
              ? .fromLTRB(
                  left: .new(color: colorCard, width: borderWidth),
                  top: .new(color: colorCard, width: borderWidth),
                  bottom: .new(color: colorCard, width: borderWidth),
                )
              : null,
          image: DecorationImage(image: NetworkImage(path), fit: .cover),
        ),
      ),
    );
  }
}

class DetailCardStyle {
  const DetailCardStyle({
    this.color,
    this.padding,
    this.borderRadius,
    this.titleStyle,
    this.subTitleStyle,
  });

  final Color? color;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
}

class ImageStyle {
  const ImageStyle({
    this.height = 64.0,
    this.width = 64.0,
    this.borderRadius = const .all(.circular(12.0)),
  });

  final double height;
  final double width;
  final BorderRadius borderRadius;
}
