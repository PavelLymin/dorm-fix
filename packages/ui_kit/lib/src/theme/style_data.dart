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

class StylesScope extends StatelessWidget {
  const StylesScope({super.key, required this.styleData, required this.child});

  final StyleData styleData;
  final Widget child;

  static StyleData of(BuildContext context) {
    try {
      final result = context
          .dependOnInheritedWidgetOfExactType<_InheritedStyle>();
      if (result == null) {
        throw Exception(
          'No Styles found in context. Make sure to wrap your widget tree with Styles.',
        );
      }

      return result.styleData;
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(e, stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedStyle(styleData: styleData, child: child);
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
