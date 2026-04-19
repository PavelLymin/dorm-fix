import 'package:ui_kit/ui.dart';

import 'auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverSafeArea(
            sliver: SliverPadding(
              padding: AppInsets.screen,
              sliver: SliverMainAxisGroup(
                slivers: [
                  const SliverAppBar(
                    title: Text('Вход в профиль'),
                    toolbarHeight: 42.0,
                  ),
                  const SliverToBoxAdapter(child: AuthForm()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
