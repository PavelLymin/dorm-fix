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
    required this.pinCodeController,
    super.key,
  });

  final FocusNode emailFocusNode;
  final FocusNode phoneFocusNode;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneController;
  final TextEditingController pinCodeController;

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
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorPalette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        WindowSizeScope.of(context).isMediumOrLarger
            ? UiText.titleLarge(
                'Начните использовать приложение',
                style: TextStyle(fontWeight: FontWeight.w700),
              )
            : UiText.titleMedium(
                'Начните использовать приложение',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
        const SizedBox(height: 32),
        ValueListenableBuilder(
          valueListenable: _isPhoneNumber,
          builder: (context, value, child) => value
              ? Column(
                  children: [
                    UiTextField.standard(
                      focusNode: widget.phoneFocusNode,
                      controller: widget.phoneController,
                      keyboardType: TextInputType.phone,
                      style: UiTextFieldStyle(
                        filled: true,
                        fillColor: color.primary,
                        prefixIcon: Icon(Icons.phone_enabled_outlined),
                        suffixIcon: _clearSuffixIcon(widget.phoneController),
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeInOutBack,
                      child: BlocBuilder<AuthButtonBloc, AuthButtonState>(
                        buildWhen: (previous, current) {
                          final bool wasPin = previous.maybeMap(
                            isPin: () => true,
                            orElse: () => false,
                          );
                          final bool isPin = current.maybeMap(
                            isPin: () => true,
                            orElse: () => false,
                          );
                          return wasPin != isPin;
                        },
                        builder: (context, state) {
                          return state.maybeMap(
                            orElse: () {
                              return PinCode(
                                length: 6,
                                isEnable: false,
                                isFocus: false,
                                controller: widget.pinCodeController,
                              );
                            },
                            isPin: () => PinCode(
                              length: 6,
                              isEnable: true,
                              isFocus: true,
                              controller: widget.pinCodeController,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(1.5),
                          child: UiText.bodyLarge('Изменить номер?'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                )
              : Column(
                  children: [
                    UiTextField.standard(
                      focusNode: widget.emailFocusNode,
                      controller: widget.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: UiTextFieldStyle(
                        filled: true,
                        fillColor: color.primary,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                        ),
                        hintText: 'name@mail.ru или +71234567890',
                        prefixIcon: Icon(Icons.email_outlined),
                        suffixIcon: _clearSuffixIcon(widget.emailController),
                      ),
                    ),
                    const SizedBox(height: 6),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeInOutBack,
                      child: UiTextField.standard(
                        controller: widget.passwordController,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        style: UiTextFieldStyle(
                          filled: true,
                          fillColor: color.primary,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                          ),
                          hintText: 'Пароль',
                          prefixIcon: Icon(Icons.password_outlined),
                          suffixIcon: _visibilitySuffixIcon(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(1.5),
                          child: UiText.bodyLarge('Забыли пароль?'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
        ),
      ],
    );
  }
}

mixin _SignInFormStateMixin on State<SignInForm> {
  final _isPhoneNumber = ValueNotifier<bool>(false);
  bool _obscureText = true;
  bool _clearText = false;

  void _emailListener() {
    _onChanged(widget.emailController.text);
    if (widget.emailController.text.startsWith('+')) {
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        setState(() {
          widget.phoneController.text = widget.emailController.text;
          widget.emailController.clear();
          _isPhoneNumber.value = true;
          widget.emailFocusNode.unfocus();
          widget.phoneFocusNode.requestFocus();
        });
      });
    }
  }

  void _phonelistener() {
    _onChanged(widget.phoneController.text);
    if (!widget.phoneController.text.startsWith('+')) {
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        setState(() {
          widget.emailController.text = widget.phoneController.text;
          widget.pinCodeController.clear();
          widget.phoneController.clear();
          _isPhoneNumber.value = false;
          widget.phoneFocusNode.unfocus();
          widget.emailFocusNode.requestFocus();
        });
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
