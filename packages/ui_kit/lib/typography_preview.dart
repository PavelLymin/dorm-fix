import 'package:ui_kit/ui.dart';

class TypographyPreview extends StatelessWidget {
  const TypographyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          UiText2.h1('H1'),
          const SizedBox(height: 8),
          UiText2.h1Bold('H1 Bold'),
          const SizedBox(height: 8),
          UiText2.h2('H2'),
          const SizedBox(height: 8),
          UiText2.h2Bold('H2 Bold'),
          const SizedBox(height: 8),
          UiText2.h3('H3'),
          const SizedBox(height: 8),
          UiText2.h3Bold('H3 Bold'),
          const SizedBox(height: 8),
          UiText2.h4('H4'),
          const SizedBox(height: 8),
          UiText2.h4Bold('H4 Bold'),
          const SizedBox(height: 8),
          UiText2.h5('H5'),
          const SizedBox(height: 8),
          UiText2.h5Bold('H5 Bold'),
          const SizedBox(height: 8),
          UiText2.l('L'),
          const SizedBox(height: 8),
          UiText2.lBold('L Bold'),
          const SizedBox(height: 8),
          UiText2.m('M'),
          const SizedBox(height: 8),
          UiText2.mBold('M Bold'),
          const SizedBox(height: 8),
          UiText2.s('S'),
          const SizedBox(height: 8),
          UiText2.sBold('S Bold'),
          const SizedBox(height: 8),
          UiText2.xs('XS'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
