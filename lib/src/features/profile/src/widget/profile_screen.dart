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
        SliverAppBar(
          title: Row(
            crossAxisAlignment: .center,
            mainAxisAlignment: .spaceBetween,
            mainAxisSize: .max,
            children: [
              const Text('Профиль'),
              UiButton.filledPrimary(
                onPressed: () {},
                label: UiText.bodyMedium('Изм.'),
                style: ButtonStyle(minimumSize: .all(.square(40.0))),
              ),
            ],
          ),
          pinned: true,
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
