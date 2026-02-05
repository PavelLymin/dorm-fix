import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../../authentication.dart';

class EmailPasswordForm extends StatefulWidget {
  const EmailPasswordForm({
    required this.emailController,
    required this.passwordController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.onTap,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final Function() onTap;

  @override
  State<EmailPasswordForm> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm>
    with _EmailPasswordFormStateMixin {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UiTextField.standard(
          focusNode: widget.emailFocusNode,
          controller: widget.emailController,
          keyboardType: .emailAddress,
          textInputAction: .next,
          style: UiTextFieldStyle(
            hintText: 'name@mail.ru или +71234567890',
            prefixIcon: const Icon(Icons.email_outlined),
            suffixIcon: widget.emailController.text.isEmpty
                ? null
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () =>
                        setState(() => widget.emailController.clear()),
                  ),
          ),
        ),
        const SizedBox(height: 24),
        UiTextField.standard(
          controller: widget.passwordController,
          obscureText: _obscureText,
          keyboardType: .visiblePassword,
          textInputAction: .done,
          style: UiTextFieldStyle(
            hintText: 'Пароль',
            prefixIcon: const Icon(Icons.password_outlined),
            suffixIcon: IconButton(
              icon: _obscureText
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
              onPressed: () => setState(() => _obscureText = !_obscureText),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            borderRadius: const .all(.circular(8.0)),
            onTap: () {},
            child: Padding(
              padding: const .all(1.5),
              child: UiText.bodyLarge('Забыли пароль?'),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

mixin _EmailPasswordFormStateMixin on State<EmailPasswordForm> {
  bool _isValidateEmail = false;
  bool _isValidatePassword = false;

  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(_onEmailChanged);
    widget.passwordController.addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    widget.emailController.removeListener(_onEmailChanged);
    widget.passwordController.removeListener(_onPasswordChanged);
    super.dispose();
  }

  void _onEmailChanged() {
    if (EmailPasswordValidator.validateEmail(widget.emailController.text) &&
        !_isValidateEmail) {
      _isValidateEmail = true;
      context.read<AuthButtonBloc>().add(
        AuthButtonEvent.changeState(isEmail: true),
      );
    } else if (!EmailPasswordValidator.validateEmail(
          widget.emailController.text,
        ) &&
        _isValidateEmail) {
      _isValidateEmail = false;
      context.read<AuthButtonBloc>().add(
        AuthButtonEvent.changeState(isEmail: false),
      );
    }
  }

  void _onPasswordChanged() {
    if (EmailPasswordValidator.validatePassword(
          widget.passwordController.text,
        ) &&
        !_isValidatePassword) {
      _isValidatePassword = true;
      context.read<AuthButtonBloc>().add(
        AuthButtonEvent.changeState(isPassword: true),
      );
    } else if (!EmailPasswordValidator.validatePassword(
          widget.passwordController.text,
        ) &&
        _isValidatePassword) {
      _isValidatePassword = false;
      context.read<AuthButtonBloc>().add(
        AuthButtonEvent.changeState(isPassword: false),
      );
    }
  }
}
