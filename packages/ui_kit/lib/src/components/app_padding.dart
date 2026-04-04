import 'package:ui_kit/ui.dart';

// class AppPadding {
//   const AppPadding();

//   double get defaultPadding => 8.0;

//   EdgeInsets get pagePadding => .symmetric(horizontal: defaultPadding * 2);

//   EdgeInsets get contentPadding =>
//       .symmetric(horizontal: defaultPadding * 2, vertical: defaultPadding);

//   EdgeInsets get allSmall => .all(defaultPadding);
//   EdgeInsets get allMedium => .all(defaultPadding * 2);
//   EdgeInsets get allLarge => .all(defaultPadding * 3);

//   EdgeInsets get horizontal => .symmetric(horizontal: defaultPadding);
//   EdgeInsets get vertical => .symmetric(vertical: defaultPadding);
//   EdgeInsets get symmetric =>
//       .symmetric(horizontal: defaultPadding, vertical: defaultPadding);

//   EdgeInsets get only => .only(
//     top: defaultPadding,
//     right: defaultPadding,
//     bottom: defaultPadding,
//     left: defaultPadding,
//   );

//   EdgeInsets appBar({required BuildContext context}) => .only(
//     top: MediaQuery.of(context).padding.top,
//     bottom: defaultPadding * 2,
//     right: defaultPadding * 2,
//     left: defaultPadding * 2,
//   );

//   EdgeInsets allIncrement({required double increment}) =>
//       .all(defaultPadding * increment);

//   EdgeInsets horizontalIncrement({required double increment}) =>
//       .symmetric(horizontal: defaultPadding * increment, vertical: .0);

//   EdgeInsets verticalIncrement({required double increment}) =>
//       .symmetric(horizontal: .0, vertical: defaultPadding * increment);

//   EdgeInsets symmetricIncrement({double horizontal = 0, double vertical = 0}) =>
//       .symmetric(
//         horizontal: defaultPadding * horizontal,
//         vertical: defaultPadding * vertical,
//       );

//   EdgeInsets onlyIncrement({
//     double top = 0,
//     double right = 0,
//     double bottom = 0,
//     double left = 0,
//   }) => .only(
//     top: defaultPadding * top,
//     right: defaultPadding * right,
//     bottom: defaultPadding * bottom,
//     left: defaultPadding * left,
//   );
// }

abstract final class AppSpacing {
  static const xxxs = 4.0;
  static const xxs = 6.0;
  static const xs = 8.0;
  static const sm = 10.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const xxl = 24.0;
  static const xxxl = 32.0;
}

abstract final class AppInsets {
  static const screen = EdgeInsets.symmetric(horizontal: AppSpacing.xl);
  static const section = EdgeInsets.symmetric(vertical: AppSpacing.xxl);
  static const card = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.md,
  );
  static const sheet = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.xl,
  );
  static const button = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.md,
  );
  static const itemDense = EdgeInsets.symmetric(
    horizontal: AppSpacing.xxs,
    vertical: 0.0,
  );
  static const item = EdgeInsets.symmetric(
    horizontal: AppSpacing.xs,
    vertical: 0.0,
  );
}
