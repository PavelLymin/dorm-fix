import 'package:ui_kit/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state_management/authentication/authentication_bloc.dart';

class AuthWithSocial extends StatelessWidget {
  const AuthWithSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.symmetricIncrement(horizontal: 3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Divider(thickness: 3),
                ),
              ),
              const SizedBox(width: 8),
              UiText.bodyLarge('ИЛИ'),
              const SizedBox(width: 8),
              const Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Divider(thickness: 3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: UiButton.icon(
                  icon: Image.asset(
                    ImagesHelper.googleLogo,
                    height: 32,
                    width: 32,
                  ),
                  onPressed: () => context.read<AuthBloc>().add(
                    AuthEvent.signInWithGoogle(),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.transparent,
                    ),
                    side: WidgetStatePropertyAll<BorderSide>(
                      BorderSide(
                        color: Theme.of(context).colorPalette.buttonBorder,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: UiButton.icon(
                  icon: Image.asset(
                    ImagesHelper.googleLogo,
                    height: 32,
                    width: 32,
                  ),
                  onPressed: () => context.read<AuthBloc>().add(
                    AuthEvent.signInWithGoogle(),
                  ),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(
                      Colors.transparent,
                    ),
                    side: WidgetStatePropertyAll<BorderSide>(
                      BorderSide(
                        color: Theme.of(context).colorPalette.buttonBorder,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
