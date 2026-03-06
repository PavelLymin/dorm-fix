import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../authentication.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.emailAndPassword,
    required this.verifyPhoneNumber,
    required this.phoneNumber,
  });

  final Function emailAndPassword;
  final Function verifyPhoneNumber;
  final Function phoneNumber;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthButtonBloc, AuthButtonState>(
        builder: (context, state) => UiButton.filledPrimary(
          onPressed: () => state.mapOrNull(
            isEmailPassword: () => emailAndPassword(),
            isPhoneNumber: () => verifyPhoneNumber(),
            isPin: () => phoneNumber(),
          ),
          enabled: state.isEnabled,
          label: state.isLoading
              ? SizedBox.square(
                  dimension: 20.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: context.colorPalette.primary.withValues(alpha: .38),
                  ),
                )
              : const Text('Далее'),
        ),
      );
}
