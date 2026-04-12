import 'package:ui_kit/ui.dart';

class StepperPreview extends StatelessWidget {
  const StepperPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return UiCard.standart(
      child: UiStepper(
        currentStep: 1,
        steps: const [
          StepItem(title: 'Создана', subtitle: '4 апреля в 20:01'),
          StepItem(title: 'Передана мастеру', subtitle: '5 апреля в 12:15'),
          StepItem(title: 'Завершена'),
        ],
      ),
    );
  }
}
