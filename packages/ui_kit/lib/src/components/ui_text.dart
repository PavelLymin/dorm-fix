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
    TextStyle? Function(AppTypography2)? styleBuilder,
    super.key,
  }) : _styleBuilder = styleBuilder;

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? color;
  final bool? softWrap;
  final TextStyle? Function(AppTypography2)? _styleBuilder;

  factory UiText.h1(
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
    styleBuilder: (typography) => typography.h1,
    key: key,
  );

  factory UiText.h1Bold(
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
    styleBuilder: (typography) => typography.h1Bold,
    key: key,
  );

  factory UiText.h2(
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
    styleBuilder: (typography) => typography.h2,
    key: key,
  );

  factory UiText.h2Bold(
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
    styleBuilder: (typography) => typography.h2Bold,
    key: key,
  );

  factory UiText.h3(
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
    styleBuilder: (typography) => typography.h3,
    key: key,
  );

  factory UiText.h3Bold(
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
    styleBuilder: (typography) => typography.h3Bold,
    key: key,
  );

  factory UiText.h4(
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
    styleBuilder: (typography) => typography.h4,
    key: key,
  );

  factory UiText.h4Bold(
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
    styleBuilder: (typography) => typography.h4Bold,
    key: key,
  );

  factory UiText.h5(
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
    styleBuilder: (typography) => typography.h5,
    key: key,
  );

  factory UiText.h5Bold(
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
    styleBuilder: (typography) => typography.h5Bold,
    key: key,
  );

  factory UiText.l(
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
    styleBuilder: (typography) => typography.l,
    key: key,
  );

  factory UiText.lBold(
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
    styleBuilder: (typography) => typography.lBold,
    key: key,
  );

  factory UiText.m(
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
    styleBuilder: (typography) => typography.m,
    key: key,
  );

  factory UiText.mBold(
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
    styleBuilder: (typography) => typography.mBold,
    key: key,
  );

  factory UiText.s(
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
    styleBuilder: (typography) => typography.s,
    key: key,
  );

  factory UiText.sBold(
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
    styleBuilder: (typography) => typography.sBold,
    key: key,
  );

  factory UiText.xs(
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
    styleBuilder: (typography) => typography.xs,
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).appTypography2;
    final palette = Theme.of(context).colorPalette;

    final baseStyle = _styleBuilder?.call(typography) ?? typography.h4;
    return Text(
      data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      softWrap: softWrap,
      style: baseStyle
          .copyWith(color: color ?? palette.foreground)
          .merge(style),
    );
  }
}
