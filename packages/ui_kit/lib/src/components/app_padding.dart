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

  static EdgeInsets allIncrement({required int increment}) =>
      .all(defaultPadding * increment);

  static EdgeInsets horizontalIncrement({required double increment}) =>
      .symmetric(
        horizontal: defaultPadding * increment,
        vertical: defaultPadding,
      );

  static EdgeInsets verticalIncrement({required int increment}) => .symmetric(
    horizontal: defaultPadding,
    vertical: defaultPadding * increment,
  );

  static EdgeInsets symmetricIncrement({
    int horizontal = 0,
    int vertical = 0,
  }) => .symmetric(
    horizontal: defaultPadding * horizontal,
    vertical: defaultPadding * vertical,
  );

  static EdgeInsets onlyIncrement({
    int top = 0,
    int right = 0,
    int bottom = 0,
    int left = 0,
  }) => .only(
    top: defaultPadding * top,
    right: defaultPadding * right,
    bottom: defaultPadding * bottom,
    left: defaultPadding * left,
  );
}
