import 'package:ui_kit/ui.dart';

class AppPadding {
  static const double defaultPadding = 8.0;

  static const EdgeInsets allSmall = .all(defaultPadding);
  static const EdgeInsets allMedium = .all(defaultPadding * 2);
  static const EdgeInsets allLarge = .all(defaultPadding * 3);

  static const EdgeInsets horizontal = .symmetric(horizontal: defaultPadding);
  static const EdgeInsets vertical = .symmetric(vertical: defaultPadding);
  static const EdgeInsets symmetric = .symmetric(
    horizontal: defaultPadding,
    vertical: defaultPadding,
  );

  static const EdgeInsets only = .only(
    top: defaultPadding,
    right: defaultPadding,
    bottom: defaultPadding,
    left: defaultPadding,
  );

  static EdgeInsets allIncrement({required double increment}) =>
      .all(defaultPadding * increment);

  static EdgeInsets horizontalIncrement({required double increment}) =>
      .symmetric(
        horizontal: defaultPadding * increment,
        vertical: defaultPadding,
      );

  static EdgeInsets verticalIncrement({required double increment}) =>
      .symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding * increment,
      );

  static EdgeInsets symmetricIncrement({
    double horizontal = 0,
    double vertical = 0,
  }) => .symmetric(
    horizontal: defaultPadding * horizontal,
    vertical: defaultPadding * vertical,
  );

  static EdgeInsets onlyIncrement({
    double top = 0,
    double right = 0,
    double bottom = 0,
    double left = 0,
  }) => .only(
    top: defaultPadding * top,
    right: defaultPadding * right,
    bottom: defaultPadding * bottom,
    left: defaultPadding * left,
  );
}
