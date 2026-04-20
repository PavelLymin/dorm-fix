import 'package:ui_kit/ui.dart';

import 'auth_form.dart';
import 'auth_services.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход в профиль'), toolbarHeight: 42.0),
      body: SafeArea(
        child: Padding(
          padding: AppInsets.screen,
          child: Column(
            crossAxisAlignment: .center,
            mainAxisAlignment: .start,
            children: [const AuthForm(), const Spacer(), AuthServices()],
          ),
        ),
      ),
    );
  }
}
