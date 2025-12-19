import 'package:ui_kit/ui.dart';
import 'log_out.dart';
import 'personal_avatar.dart';
import 'personal_data.dart';
import 'theme_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: AppPadding.horizontalIncrement(increment: 3),
            child: const Column(
              crossAxisAlignment: .stretch,
              mainAxisAlignment: .start,
              children: [
                Stack(
                  children: [
                    Center(child: PersonalAvatar()),
                    Align(alignment: .topRight, child: PersonalTheme()),
                  ],
                ),
                SizedBox(height: 24),
                PersonalData(),
                SizedBox(height: 32),
                LogOut(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
