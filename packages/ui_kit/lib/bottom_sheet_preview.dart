import 'package:ui_kit/ui.dart';

class BottomSheetPreview extends StatelessWidget {
  const BottomSheetPreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Padding(
      padding: AppPadding.allSmall,
      child: UiButton.filledPrimary(
        onPressed: () => showUiBottomSheet(
          context,
          widget: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .stretch,
            mainAxisSize: .min,
            children: [
              UiText.titleMedium('Modal bottom sheet'),
              const SizedBox(height: 24),
              UiButton.filledPrimary(
                onPressed: () => Navigator.pop(context),
                label: UiText.bodyMedium('Close'),
              ),
            ],
          ),
        ),
        label: UiText.bodyMedium('Show bottom sheet'),
      ),
    ),
  );
}
