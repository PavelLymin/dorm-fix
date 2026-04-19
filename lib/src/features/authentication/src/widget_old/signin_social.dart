import 'package:ui_kit/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../authentication.dart';

class AuthWithSocial extends StatelessWidget {
  const AuthWithSocial({super.key});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .center,
    crossAxisAlignment: .center,
    mainAxisSize: .min,
    children: [
      Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          const Flexible(child: Divider(thickness: 3.0)),
          const SizedBox(width: 8.0),
          UiText.bodyLarge('ИЛИ'),
          const SizedBox(width: 8.0),
          const Flexible(child: Divider(thickness: 3.0)),
        ],
      ),
      const SizedBox(height: 16.0),
      Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          Expanded(
            child: UiButton.icon(
              icon: Image.asset(
                ImagesHelper.googleLogo,
                height: 32.0,
                width: 32.0,
              ),
              onPressed: () =>
                  context.read<AuthBloc>().add(AuthEvent.signInWithGoogle()),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: UiButton.icon(
              icon: Image.asset(
                ImagesHelper.googleLogo,
                height: 32.0,
                width: 32.0,
              ),
              onPressed: () =>
                  context.read<AuthBloc>().add(AuthEvent.signInWithGoogle()),
            ),
          ),
        ],
      ),
    ],
  );
}
