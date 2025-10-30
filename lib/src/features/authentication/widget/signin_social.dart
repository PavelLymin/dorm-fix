import 'package:ui_kit/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state_management/authentication/authentication_bloc.dart';

class AuthWithSocial extends StatelessWidget {
  const AuthWithSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 100, child: Divider(thickness: 3)),
            const SizedBox(width: 8),
            const Text('ИЛИ'),
            const SizedBox(width: 8),
            const SizedBox(width: 100, child: Divider(thickness: 3)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: UiButton.icon(
                icon: Image.asset(
                  'packages/ui_kit/assets/icons/google.png',
                  height: 32,
                  width: 32,
                ),
                onPressed: () =>
                    context.read<AuthBloc>().add(AuthEvent.signInWithGoogle()),
                style: ButtonStyle(
                  side: WidgetStatePropertyAll<BorderSide>(
                    BorderSide(color: Theme.of(context).colorPalette.border),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: UiButton.icon(
                icon: Image.asset(
                  'packages/ui_kit/assets/icons/apple.png',
                  height: 32,
                  width: 32,
                ),
                onPressed: () =>
                    context.read<AuthBloc>().add(AuthEvent.signInWithGoogle()),
                style: ButtonStyle(
                  side: WidgetStatePropertyAll<BorderSide>(
                    BorderSide(color: Theme.of(context).colorPalette.border),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
