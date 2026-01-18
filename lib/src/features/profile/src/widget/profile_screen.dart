import 'package:ui_kit/ui.dart';
import 'personal_avatar.dart';
import 'personal_data.dart';
import 'settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: AppPadding.allMedium,
    child: CustomScrollView(
      slivers: [
        SliverPadding(
          padding: AppPadding.symmetricIncrement(vertical: 2),
          sliver: SliverAppBar(
            title: const Text('Профиль'),
            pinned: true,
            actions: [
              UiButton.filledPrimary(
                onPressed: () {},
                label: UiText.bodyMedium('Изм.'),
              ),
            ],
          ),
        ),
        SliverList.list(
          children: const [
            PersonalAvatar(),
            SizedBox(height: 24.0),
            PersonalData(),
            SizedBox(height: 24.0),
            Settings(),
          ],
        ),
      ],
    ),
  );
}
