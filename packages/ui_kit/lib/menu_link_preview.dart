import 'ui.dart';

class MenuLinkPreview extends StatelessWidget {
  const MenuLinkPreview({super.key});

  @override
  Widget build(BuildContext context) => UiCard.standart(
    child: Padding(
      padding: AppPadding.allSmall,
      child: MenuLink(
        actions: {
          'Светлая тема': () {},
          'Темная тема': () {},
          'Синяя тема': () {},
        },
        child: SizedBox.square(
          dimension: 48,
          child: Icon(Icons.light_mode_rounded),
        ),
      ),
    ),
  );
}
