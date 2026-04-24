import 'package:ui_kit/ui.dart';

class BottomSheetPreview extends StatelessWidget {
  const BottomSheetPreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: UiButton.filledPrimary(
      onPressed: () => showUiBottomSheet(
        context,
        title: 'Modal bottom sheet',
        widget: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            UiText2.m('Modal bottom sheet'),
            const SizedBox(height: 24),
            UiButton.filledPrimary(
              onPressed: () => Navigator.pop(context),
              label: UiText2.m('Close'),
            ),
          ],
        ),
      ),
      label: Text('Show bottom sheet'),
    ),
  );
}
