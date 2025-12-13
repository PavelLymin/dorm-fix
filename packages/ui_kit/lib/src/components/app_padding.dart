import 'package:ui_kit/ui.dart';

class AppPadding {
  static const double defaultPadding = 8.0;

  static const EdgeInsets allSmall = EdgeInsets.all(defaultPadding);
  static const EdgeInsets allMedium = EdgeInsets.all(defaultPadding * 2);
  static const EdgeInsets allLarge = EdgeInsets.all(defaultPadding * 3);

  static const EdgeInsets horizontal = EdgeInsets.symmetric(
    horizontal: defaultPadding,
  );
  static const EdgeInsets vertical = EdgeInsets.symmetric(
    vertical: defaultPadding,
  );
  static const EdgeInsets symmetric = EdgeInsets.symmetric(
    horizontal: defaultPadding,
    vertical: defaultPadding,
  );

  static const EdgeInsets only = EdgeInsets.only(
    top: defaultPadding,
    right: defaultPadding,
    bottom: defaultPadding,
    left: defaultPadding,
  );

  static EdgeInsets allIncrement({required int increment}) =>
      EdgeInsets.all(defaultPadding * increment);

  static EdgeInsets horizontalIncrement({required double increment}) =>
      EdgeInsets.symmetric(
        horizontal: defaultPadding * increment,
        vertical: defaultPadding,
      );

  static EdgeInsets verticalIncrement({required int increment}) =>
      EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding * increment,
      );

  static EdgeInsets symmetricIncrement({
    int horizontal = 0,
    int vertical = 0,
  }) => EdgeInsets.symmetric(
    horizontal: defaultPadding * horizontal,
    vertical: defaultPadding * vertical,
  );

  static EdgeInsets onlyIncrement({
    int top = 0,
    int right = 0,
    int bottom = 0,
    int left = 0,
  }) => EdgeInsets.only(
    top: defaultPadding * top,
    right: defaultPadding * right,
    bottom: defaultPadding * bottom,
    left: defaultPadding * left,
  );
}
