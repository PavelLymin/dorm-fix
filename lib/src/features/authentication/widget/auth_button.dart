import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../state_management/auth_button/auth_button_bloc.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.signInWithEmailAndPassword,
    required this.verifyPhoneNumber,
    required this.signInWithPhoneNumber,
  });

  final Function signInWithEmailAndPassword;
  final Function verifyPhoneNumber;
  final Function signInWithPhoneNumber;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    width: double.infinity,
    child: BlocBuilder<AuthButtonBloc, AuthButtonState>(
      builder: (context, state) => UiButton.filledPrimary(
        onPressed: () => state.mapOrNull(
          isEmailPassword: () => signInWithEmailAndPassword(),
          isPhoneNumber: () => verifyPhoneNumber(),
          isPin: () => signInWithPhoneNumber(),
        ),
        enabled: state.isEnabled,
        label: state.isLoading
            ? SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(
                    context,
                  ).colorPalette.primary.withValues(alpha: .38),
                ),
              )
            : const Text('Далее'),
      ),
    ),
  );
}
