import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_kit/ui.dart';
import '../state_management/auth_button/auth_button_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    required this.emailFocusNode,
    required this.phoneFocusNode,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    super.key,
  });

  final FocusNode emailFocusNode;
  final FocusNode phoneFocusNode;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with _SignInFormStateMixin {
  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(_emailListener);
    widget.phoneController.addListener(_phonelistener);
  }

  @override
  void dispose() {
    widget.emailController.removeListener(_emailListener);
    widget.phoneController.removeListener(_phonelistener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 16),
      WindowSizeScope.of(context).isMediumOrLarger
          ? UiText.titleLarge('Начните использовать приложение')
          : UiText.titleMedium('Начните использовать приложение'),
      const SizedBox(height: 32),
      ValueListenableBuilder(
        valueListenable: _isPhoneNumber,
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            value
                ? Column(
                    children: [
                      UiTextField.standard(
                        focusNode: widget.phoneFocusNode,
                        controller: widget.phoneController,
                        keyboardType: TextInputType.phone,
                        style: UiTextFieldStyle(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          prefixIcon: Icon(Icons.phone_enabled_outlined),
                          suffixIcon: _clearSuffixIcon(widget.phoneController),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        child: BlocBuilder<AuthButtonBloc, AuthButtonState>(
                          builder: (context, state) {
                            return state.maybeMap(
                              orElse: () {
                                PinScope.of(context).pin.clear();
                                return const Pin(isEnable: false);
                              },
                              isPin: () => const Pin(isEnable: true),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      UiTextField.standard(
                        focusNode: widget.emailFocusNode,
                        controller: widget.emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: UiTextFieldStyle(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          hintText: 'name@mail.ru или +71234567890',
                          prefixIcon: Icon(Icons.email_outlined),
                          suffixIcon: _clearSuffixIcon(widget.emailController),
                        ),
                      ),
                      const SizedBox(height: 16),
                      UiTextField.standard(
                        controller: widget.passwordController,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        style: UiTextFieldStyle(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          hintText: 'Пароль',
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: _visibilitySuffixIcon(),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.all(1.5),
                child: Text('Забыли пароль?'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    ],
  );
}

mixin _SignInFormStateMixin on State<SignInForm> {
  final _isPhoneNumber = ValueNotifier<bool>(false);
  bool _obscureText = true;
  bool _clearText = false;

  void _emailListener() {
    _onChanged(widget.emailController.text);
    if (widget.emailController.text.startsWith('+7')) {
      setState(() {
        widget.phoneController.text = widget.emailController.text;
        widget.emailController.clear();
        _isPhoneNumber.value = true;
        widget.emailFocusNode.unfocus();
        widget.phoneFocusNode.requestFocus();
      });
    }
  }

  void _phonelistener() {
    _onChanged(widget.phoneController.text);
    if (!widget.phoneController.text.startsWith('+7')) {
      setState(() {
        widget.emailController.text = widget.phoneController.text;
        PinScope.of(context).pin.clear();
        widget.phoneController.clear();
        _isPhoneNumber.value = false;
        widget.phoneFocusNode.unfocus();
        widget.emailFocusNode.requestFocus();
      });
    }
  }

  void _onChanged(String text) {
    if (text.isNotEmpty && !_clearText) {
      setState(() {
        _clearText = true;
      });
    } else if (text.isEmpty && _clearText) {
      setState(() {
        _clearText = false;
      });
    }
  }

  Widget? _clearSuffixIcon(TextEditingController controller) =>
      controller.text.isEmpty
      ? null
      : IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              controller.clear();
            });
          },
        );

  Widget? _visibilitySuffixIcon() => IconButton(
    icon: _obscureText
        ? const Icon(Icons.visibility_off)
        : const Icon(Icons.visibility),
    onPressed: () {
      setState(() {
        _obscureText = !_obscureText;
      });
    },
  );
}
