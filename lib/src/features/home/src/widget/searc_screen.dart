import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';

class SearcScreen extends StatelessWidget {
  const SearcScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppPadding.pagePadding,
        child: Column(
          children: [
            Center(child: UiTextField.standard()),
            UiButton.filledPrimary(
              onPressed: () {
                context.router.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
