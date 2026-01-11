import 'package:ui_kit/ui.dart';
import 'personal_avatar.dart';
import 'personal_data.dart';
import 'settings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      const SliverAppBar(title: Text('Профиль'), pinned: true),
      SliverPadding(
        padding: AppPadding.allMedium,
        sliver: SliverList.list(
          children: const [
            PersonalAvatar(),
            SizedBox(height: 24.0),
            PersonalData(),
            SizedBox(height: 24.0),
            Settings(),
          ],
        ),
      ),
    ],
  );
}
