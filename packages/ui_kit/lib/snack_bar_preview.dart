import 'package:ui_kit/ui.dart';

class SnackBarPreview extends StatelessWidget {
  const SnackBarPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiButton.filledPrimary(
        label: Text('Show SnackBar'),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorPalette.card,
              duration: const Duration(seconds: 3),
              padding: const .all(24.0),
              behavior: .floating,
              showCloseIcon: true,
              content: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                spacing: 8.0,
                children: [
                  UiText.bodyLarge('Button pressed'),
                  UiText.bodyLarge(
                    'We recommend placing FToaster in the builder method of MaterialApp/WidgetsApp/CupertinoApp',
                    style: TextStyle(
                      color: Theme.of(context).colorPalette.mutedForeground,
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: .circular(16.0),
                side: BorderSide(
                  color: Theme.of(context).colorPalette.borderStrong,
                ),
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
