import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../authentication.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.verifyPhoneNumber, this.phoneNumber});

  final void Function()? verifyPhoneNumber;
  final void Function()? phoneNumber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return BlocBuilder<AuthButtonBloc, AuthButtonState>(
      builder: (context, state) => UiButton.filledPrimary(
        onPressed: () => state.mapOrNull(
          isPhoneNumber: verifyPhoneNumber,
          isPin: phoneNumber,
        ),
        enabled: state.isEnabled,
        label: state.isLoading
            ? SizedBox.square(
                dimension: 20.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: palette.foregroundAccent,
                ),
              )
            : const Text('Далее'),
      ),
    );
  }
}
