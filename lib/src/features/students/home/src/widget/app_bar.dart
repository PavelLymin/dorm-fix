import 'package:ui_kit/ui.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Главная'),
      toolbarHeight: 42.0,
      actions: [
        UiButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.notification_add_outlined),
        ),
      ],
    );
  }
}
