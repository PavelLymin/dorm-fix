import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../../authentication.dart';

class AuthServices extends StatelessWidget {
  const AuthServices({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      spacing: 16.0,
      children: [
        UiButton.filledPrimary(
          onPressed: () =>
              context.read<AuthBloc>().add(AuthEvent.signInWithGoogle()),
          label: const Text('Войти с помощью Google'),
          style: ButtonStyle(
            backgroundColor: .all(palette.buttonSecondary),
            foregroundColor: .all(palette.foreground),
          ),
        ),
        UiButton.filledPrimary(
          onPressed: () =>
              context.read<AuthBloc>().add(AuthEvent.signInWithGoogle()),
          label: const Text('Войти с помощью Telegram'),
          style: ButtonStyle(
            backgroundColor: .all(palette.buttonSecondary),
            foregroundColor: .all(palette.foreground),
          ),
        ),
      ],
    );
  }
}
