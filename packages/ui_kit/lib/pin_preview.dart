import 'package:ui_kit/ui.dart';

class PinPreview extends StatelessWidget {
  const PinPreview({super.key});

  @override
  Widget build(BuildContext context) => const UiCard(
    child: Padding(padding: EdgeInsets.all(16), child: Pin()),
  );
}
