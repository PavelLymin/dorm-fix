import 'package:ui_kit/ui.dart';
import 'personal_avatar.dart';
import 'personal_data.dart';
import 'personal_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Center(
        child: Padding(
          padding: AppPadding.horizontalIncrement(increment: 3),
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .start,
            children: [
              const Center(child: PersonalAvatar()),
              const SizedBox(height: 24),
              const PersonalData(),
              const SizedBox(height: 16),
              const PersonalTheme(),
            ],
          ),
        ),
      ),
    ),
  );
}
