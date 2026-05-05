import 'package:dorm_fix/l10n/gen/app_localizations.dart';
import 'package:ui_kit/ui.dart';

import 'auth_form.dart';
import 'auth_services.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).login_to_profile),
        toolbarHeight: 42.0,
      ),
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
