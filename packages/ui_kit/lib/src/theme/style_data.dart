import 'package:ui_kit/ui.dart';

final class StyleData {
  const StyleData({
    required this.appStyle,
    required this.lineCalendarStyle,
    required this.groupedListStyle,
  });

  final AppStyle appStyle;

  final LineCalendarStyle lineCalendarStyle;

  final GroupedListStyle groupedListStyle;
}

class StylesScope extends StatefulWidget {
  const StylesScope({super.key, this.styleData, required this.child});

  final StyleData? styleData;
  final Widget child;

  static StyleData of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<_InheritedStyle>();
    if (result == null) {
      throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a $result of the exact type',
        'out_of_scope',
      );
    }

    return result.styleData;
  }

  @override
  State<StylesScope> createState() => _StylesScopeState();
}

class _StylesScopeState extends State<StylesScope> {
  late final StyleData styleData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final appStyle = const AppStyle();
    final lineCalendarStyle = LineCalendarStyle.defaultStyle(context, appStyle);
    final groupedListStyle = GroupedListStyle.defaultStyle(context);

    styleData =
        widget.styleData ??
        StyleData(
          appStyle: appStyle,
          lineCalendarStyle: lineCalendarStyle,
          groupedListStyle: groupedListStyle,
        );
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedStyle(styleData: styleData, child: widget.child);
}

class _InheritedStyle extends InheritedTheme {
  const _InheritedStyle({required this.styleData, required super.child});

  final StyleData styleData;
  @override
  bool updateShouldNotify(covariant _InheritedStyle oldWidget) =>
      oldWidget.styleData != styleData;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      _InheritedStyle(styleData: styleData, child: child);
}

extension StylesBuildContext on BuildContext {
  StyleData get styles => StylesScope.of(this);
}
