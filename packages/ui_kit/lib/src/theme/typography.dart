import 'package:ui_kit/ui.dart';

const defaultTypography2 = AppTypography2(
  h1: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 60,
    height: 68 / 60,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
  h1Bold: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 60,
    height: 68 / 60,
    letterSpacing: 0,
    fontWeight: .w600,
    fontStyle: .normal,
  ),
  h2: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 48,
    height: 52 / 48,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
  h2Bold: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 48,
    height: 52 / 48,
    letterSpacing: 0,
    fontWeight: .w600,
    fontStyle: .normal,
  ),
  h3: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 40,
    height: 44 / 40,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
  h3Bold: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 40,
    height: 44 / 40,
    letterSpacing: 0,
    fontWeight: .w600,
    fontStyle: .normal,
  ),
  h4: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 32,
    height: 36 / 32,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
  h4Bold: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 32,
    height: 36 / 32,
    letterSpacing: 0,
    fontWeight: .w600,
    fontStyle: .normal,
  ),
  h5: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
  h5Bold: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 24,
    height: 32 / 24,
    letterSpacing: 0,
    fontWeight: .w600,
    fontStyle: .normal,
  ),
  l: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 20,
    height: 28 / 20,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
  lBold: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 20,
    height: 28 / 20,
    letterSpacing: 0,
    fontWeight: .w600,
    fontStyle: .normal,
  ),
  m: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
  mBold: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0,
    fontWeight: .w600,
    fontStyle: .normal,
  ),
  s: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 13,
    height: 20 / 13,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
  sBold: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 13,
    height: 20 / 13,
    letterSpacing: 0,
    fontWeight: .w600,
    fontStyle: .normal,
  ),
  xs: TextStyle(
    fontFamily: 'SF Pro',
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: 0,
    fontWeight: .w400,
    fontStyle: .normal,
  ),
);

class AppTypography2 extends ThemeExtension<AppTypography2> {
  const AppTypography2({
    required this.h1,
    required this.h1Bold,
    required this.h2,
    required this.h2Bold,
    required this.h3,
    required this.h3Bold,
    required this.h4,
    required this.h4Bold,
    required this.h5,
    required this.h5Bold,
    required this.l,
    required this.lBold,
    required this.m,
    required this.mBold,
    required this.s,
    required this.sBold,
    required this.xs,
  });

  final TextStyle h1;
  final TextStyle h1Bold;
  final TextStyle h2;
  final TextStyle h2Bold;
  final TextStyle h3;
  final TextStyle h3Bold;
  final TextStyle h4;
  final TextStyle h4Bold;
  final TextStyle h5;
  final TextStyle h5Bold;
  final TextStyle l;
  final TextStyle lBold;
  final TextStyle m;
  final TextStyle mBold;
  final TextStyle s;
  final TextStyle sBold;
  final TextStyle xs;

  @override
  ThemeExtension<AppTypography2> copyWith({
    TextStyle? h1,
    TextStyle? h1Bold,
    TextStyle? h2,
    TextStyle? h2Bold,
    TextStyle? h3,
    TextStyle? h3Bold,
    TextStyle? h4,
    TextStyle? h4Bold,
    TextStyle? h5,
    TextStyle? h5Bold,
    TextStyle? l,
    TextStyle? lBold,
    TextStyle? m,
    TextStyle? mBold,
    TextStyle? s,
    TextStyle? sBold,
    TextStyle? xs,
  }) => AppTypography2(
    h1: h1 ?? this.h1,
    h1Bold: h1Bold ?? this.h1Bold,
    h2: h2 ?? this.h2,
    h2Bold: h2Bold ?? this.h2Bold,
    h3: h3 ?? this.h3,
    h3Bold: h3Bold ?? this.h3Bold,
    h4: h4 ?? this.h4,
    h4Bold: h4Bold ?? this.h4Bold,
    h5: h5 ?? this.h5,
    h5Bold: h5Bold ?? this.h5Bold,
    l: l ?? this.l,
    lBold: lBold ?? this.lBold,
    m: m ?? this.m,
    mBold: mBold ?? this.mBold,
    s: s ?? this.s,
    sBold: sBold ?? this.sBold,
    xs: xs ?? this.xs,
  );

  @override
  ThemeExtension<AppTypography2> lerp(
    covariant ThemeExtension<AppTypography2>? other,
    double t,
  ) {
    if (other == null || other is! AppTypography2) return this;

    return AppTypography2(
      h1: .lerp(h1, other.h1, t)!,
      h1Bold: .lerp(h1Bold, other.h1Bold, t)!,
      h2: .lerp(h2, other.h2, t)!,
      h2Bold: .lerp(h2Bold, other.h2Bold, t)!,
      h3: .lerp(h3, other.h3, t)!,
      h3Bold: .lerp(h3Bold, other.h3Bold, t)!,
      h4: .lerp(h4, other.h4, t)!,
      h4Bold: .lerp(h4Bold, other.h4Bold, t)!,
      h5: .lerp(h5, other.h5, t)!,
      h5Bold: .lerp(h5Bold, other.h5Bold, t)!,
      l: .lerp(l, other.l, t)!,
      lBold: .lerp(lBold, other.lBold, t)!,
      m: .lerp(m, other.m, t)!,
      mBold: .lerp(mBold, other.mBold, t)!,
      s: .lerp(s, other.s, t)!,
      sBold: .lerp(sBold, other.sBold, t)!,
      xs: .lerp(xs, other.xs, t)!,
    );
  }
}
