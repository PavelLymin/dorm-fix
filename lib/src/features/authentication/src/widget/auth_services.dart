import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../../../../../l10n/gen/app_localizations.dart';
import '../../authentication.dart';

class AuthServices extends StatelessWidget {
  const AuthServices({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    final local = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      spacing: 16.0,
      children: [
        UiButton.filledPrimary(
          onPressed: () =>
              context.read<AuthBloc>().add(AuthEvent.signInWithGoogle()),
          label: Row(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            children: [
              const Icon(UiIcons.vk),
              Flexible(
                child: Align(
                  alignment: .center,
                  child: Text(local.login_via_telegram),
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor: .all(palette.buttonSecondary),
            foregroundColor: .all(palette.foreground),
          ),
        ),
        UiButton.filledPrimary(
          onPressed: () =>
              context.read<AuthBloc>().add(AuthEvent.signInWithGoogle()),
          label: Row(
            mainAxisAlignment: .start,
            crossAxisAlignment: .center,
            children: [
              const Icon(UiIcons.telegram),
              Flexible(
                child: Align(
                  alignment: .center,
                  child: Text(local.login_via_google),
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor: .all(palette.buttonSecondary),
            foregroundColor: .all(palette.foreground),
          ),
        ),
      ],
    );
  }
}
