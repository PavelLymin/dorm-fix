import 'package:auto_route/auto_route.dart';
import 'package:ui_kit/ui.dart';

class RequestSection extends StatelessWidget {
  const RequestSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      crossAxisAlignment: .center,
      children: [
        UiText2.lBold('Ваши заявки'),
        UiButton.icon(onPressed: () {}, icon: const Icon(Icons.timer_outlined)),
      ],
    );
  }
}

class CreateRequestButton extends StatelessWidget {
  const CreateRequestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return UiButton.filledPrimary(
      onPressed: () =>
          context.router.push(const NamedRoute('FormRequestScreen')),
      icon: const Icon(Icons.add_outlined),
      label: const Text('Создать заявку'),
    );
  }
}
