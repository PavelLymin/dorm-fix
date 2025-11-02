import 'package:ui_kit/ui.dart';

class UiText extends StatelessWidget {
  const UiText(
    this.data, {
    this.color,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.softWrap,
    TextStyle? Function(AppTypography)? styleBuilder,
    super.key,
  }) : _styleBuilder = styleBuilder;

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? color;
  final bool? softWrap;
  final TextStyle? Function(AppTypography)? _styleBuilder;

  factory UiText.displayLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.displayLarge,
    key: key,
  );

  factory UiText.displayMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.displayMedium,
    key: key,
  );

  factory UiText.displaySmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.displaySmall,
    key: key,
  );

  factory UiText.headlineLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.headlineLarge,
    key: key,
  );

  factory UiText.headlineMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.headlineMedium,
    key: key,
  );

  factory UiText.headlineSmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.headlineSmall,
    key: key,
  );

  factory UiText.titleLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.titleLarge,
    key: key,
  );

  factory UiText.titleMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.titleMedium,
    key: key,
  );

  factory UiText.titleSmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.titleSmall,
    key: key,
  );

  factory UiText.bodyLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.bodyLarge,
    key: key,
  );

  factory UiText.bodyMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.bodyMedium,
    key: key,
  );

  factory UiText.bodySmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.bodySmall,
    key: key,
  );

  factory UiText.labelLarge(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.labelLarge,
    key: key,
  );

  factory UiText.labelMedium(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.labelMedium,
    key: key,
  );

  factory UiText.labelSmall(
    String data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool? softWrap,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    softWrap: softWrap,
    styleBuilder: (typography) => typography.labelSmall,
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).appTypography;
    final palette = Theme.of(context).colorPalette;

    final style = _styleBuilder?.call(typography) ?? typography.bodyLarge;

    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: style.copyWith(color: color ?? palette.foreground),
    );
  }
}
