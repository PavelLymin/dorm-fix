import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';

import '../../authentication.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette2;
    return BlocBuilder<ButtonBloc, ButtonState>(
      builder: (context, state) => UiButton.filledPrimary(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: state.isLoading ? .all(palette.buttonLoading) : null,
        ),
        enabled: state.isEnabled,
        label: state.maybeMap(
          orElse: (_) => const Text('Продолжить'),
          loading: (_) => SizedBox.square(
            dimension: 20.0,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: palette.foregroundAccent,
            ),
          ),
        ),
      ),
    );
  }
}
