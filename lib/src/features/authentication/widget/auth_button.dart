import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../state_management/authentication/authentication_bloc.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.isEnable,
    required this.onPressed,
  });

  final bool isEnable;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 50,
    child: UiButton.filledPrimary(
      onPressed: onPressed,
      enabled: isEnable,
      label: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return state.isLoading
              ? SizedBox.square(
                  dimension: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(
                      context,
                    ).colorPalette.primary.withValues(alpha: .38),
                  ),
                )
              : const Text('Далее');
        },
      ),
    ),
  );
}
