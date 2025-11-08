import 'package:ui_kit/ui.dart';

class ButtonsPreview extends StatefulWidget {
  const ButtonsPreview({super.key});

  @override
  State<ButtonsPreview> createState() => _ButtonsPreview();
}

class _ButtonsPreview extends State<ButtonsPreview> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: UiCard(
        child: const Padding(
          padding: AppPadding.allSmall,
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [_FilledPrimaryButton()],
          ),
        ),
      ),
    );
  }
}

class _FilledPrimaryButton extends StatelessWidget {
  const _FilledPrimaryButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UiText.titleSmall('Filled Primary Button'),
          const SizedBox(height: 16),
          UiButton.filledGradient(
            onPressed: () {},
            label: const Text('Gradient'),
          ),
          const SizedBox(height: 8),
          UiButton.filledGradient(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {},
            label: const Text('Gradient'),
          ),
          const SizedBox(height: 8),
          UiButton.filledPrimary(
            onPressed: () {},
            label: const Text('Primary'),
          ),
          const SizedBox(height: 8),
          UiButton.filledPrimary(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {},
            label: const Text('Primary'),
          ),
          const SizedBox(height: 8),
          UiButton.filledGradient(
            onPressed: () {},
            enabled: false,
            label: const Text('Gradient'),
          ),
          const SizedBox(height: 8),
          UiButton.filledGradient(
            icon: const Icon(Icons.add_rounded),
            onPressed: () {},
            enabled: false,
            label: const Text('Gradient'),
          ),
          const SizedBox(height: 8),
          UiButton.filledPrimary(
            onPressed: () {},
            enabled: false,
            label: const Text('Primary'),
          ),
          const SizedBox(height: 8),
          UiButton.filledPrimary(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
            enabled: false,
            label: const Text('Primary'),
          ),
          const SizedBox(height: 8),
          UiButton.filledPrimary(
            onPressed: () {},
            enabled: false,
            label: SizedBox.square(
              dimension: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).colorPalette.mutedForeground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
