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
          Column(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: <Widget>[
              const Text('Modal bottom sheet'),
              ElevatedButton(
                child: const Text('Close'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        label: UiText.bodyMedium('Show bottom sheet'),
      ),
    ),
  );
}
