import 'package:ui_kit/ui.dart';

class SnackBarPreview extends StatelessWidget {
  const SnackBarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return UiCard.standart(
      child: UiButton.filledPrimary(
        label: Text('Show SnackBar'),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: palette.card,
              duration: const Duration(seconds: 3),
              padding: const .all(24.0),
              behavior: .floating,
              showCloseIcon: true,
              content: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                spacing: 8.0,
                children: [
                  UiText2.lBold('Button pressed'),
                  UiText2.m(
                    'This is a snackbar message',
                    style: TextStyle(color: palette.foregroundSecondary),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: .circular(24.0),
                side: BorderSide(color: palette.secondary),
              ),
            ),
            snackBarAnimationStyle: AnimationStyle(
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 2000),
              curve: Curves.easeInOut,
            ),
          );
        },
      ),
    );
  }
}
