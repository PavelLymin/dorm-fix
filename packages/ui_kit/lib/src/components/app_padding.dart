import 'package:ui_kit/ui.dart';

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
  static const card = EdgeInsets.only(
    right: AppSpacing.xl,
    left: AppSpacing.xl,
    top: AppSpacing.md,
    bottom: AppSpacing.lg,
  );
  static const sheet = EdgeInsets.only(
    right: AppSpacing.xl,
    top: AppSpacing.xl,
    left: AppSpacing.xl,
    bottom: AppSpacing.sm,
  );
  static const button = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
    vertical: AppSpacing.md,
  );
  static const itemDense = EdgeInsets.symmetric(
    horizontal: .0,
    vertical: AppSpacing.xxs,
  );
  static const item = EdgeInsets.symmetric(
    horizontal: .0,
    vertical: AppSpacing.xs,
  );
}
